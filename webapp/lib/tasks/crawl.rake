require 'facebook_crawler'
require 'yaml'
require 'date'

config = YAML.load_file('crawler_config.yml')

FB_groups_to_track = config['fb']['groups']
FB_pages_to_track = config['fb']['pages']
FB_FEED_PAGE_SIZE = 50

Callback_url = 'http://squirrels.vii.ovh/auth/facebook/callback'.freeze

desc 'Crawls events and posts from the given set of pages and insert the result into the database'
task :crawl, [:complete] => :environment do |_t, args|
    args.with_defaults(complete: false)

    complete_crawling = args[:complete]
    feed_limit = complete_crawling ? 2000 : FB_FEED_PAGE_SIZE

    # Setting logger level, so we have a log of both rest queries to facebook and queries to our db
    Koala::Utils.level = Logger::DEBUG if Koala
    Rails.logger.level = Logger::DEBUG if Rails

    log 'Crawler started, initializing'

    unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
        raise 'Application id and/or secret are not specified in the environment'
    end

    log 'Crawling - give me some time please!'
    time_started = Time.now

    fb_crawling feed_limit

    log "Crawling finished in #{Time.now - time_started}s :)"
end

def fb_crawling(feed_limit)
    oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
    token = oauth.get_app_access_token
    crawler = FacebookCrawler.new(token, FB_FEED_PAGE_SIZE)

    # Insert sources into DB
    log 'crawling info about groups'
    groups_info = crawler.groups_info(FB_groups_to_track)
    insert_groups_sources(groups_info)

    log 'crawling info about pages'
    pages_info = crawler.pages_info(FB_pages_to_track)
    insert_pages_sources(pages_info)

    FB_groups_to_track.each do |group|
        source = Source.find_by uid: group['id'], stype: 'group'

        next unless source.isOPEN
        log "downloading feed for group: #{group['name']}"
        result_pages = crawler.group_feed(group['id'], feed_limit)

        result_pages.each do |feed|
            insert_events(feed[:events], source)
            insert_posts(feed[:posts], source)
        end
    end

    FB_pages_to_track.each do |page|
        source = Source.find_by uid: page['id'], stype: 'page'
        page_events = crawl_page(crawler, page)
        insert_events(page_events, source)
    end
end

def crawl_page(crawler, page)
    log "downloading events from page: #{page['name']}"
    events = crawler.page_events(page)
    log "downloaded #{events.size} events"

    events
end

def insert_groups_sources(groups)
    log 'inserting info about groups'

    groups.each do |group|
        Source.from_fb_group(group).save
    end

    log 'all info added/updated'
end

def insert_pages_sources(pages)
    log 'inserting info about pages'

    pages.each do |page|
        Source.from_fb_page(page).save
    end

    log 'all info added/updated'
end

def insert_events(events, source = nil, skip_existing = false)
    log "crawled #{events.count} events, inserting them into db"

    if skip_existing
      event_uids_in_db = Event.pluck(:uid).to_set
      events = events.reject { |e| event_uids_in_db.include? e['id'] }
    end

    events.each do |event_data|
        e = Event.from_fb_event(event_data)
        e.source = source
        e.save
    end

     log "inserted/updated #{events.count} events"
end

def insert_posts(posts, source = nil, skip_existing = false)
    log "crawled #{posts.count} posts"

    if skip_existing
      post_uids_in_db = Post.pluck(:uid).to_set
      posts = posts.reject { |post| post_uids_in_db.include? post['id'] }
    end

    posts.each do |post_data|
        post = Post.from_fb_post(post_data)
        post.source = source
        post.save
    end

    log "inserted/updated #{posts.count} posts"
end

def log(message)
    puts "[#{Time.now.strftime '%d/%m/%Y %H:%M:%S:%L'}] #{message}"
end
