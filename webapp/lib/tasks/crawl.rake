require 'facebook_crawler'
require 'yaml'
require 'date'

config = YAML.load_file('crawler_config.yml')

FB_groups_to_track = config['fb']['groups']
FB_pages_to_track = config['fb']['pages']

Feed_limit = 50 # No need to have this very high, except for the first time

Callback_url = 'http://squirrels.vii.ovh/auth/facebook/callback'.freeze

desc 'Crawls events and posts from the given set of pages and insert the result into the database'
task crawl: :environment do
    puts 'Crawler started, initializing'

    # Setting logger level, so we have a log of both rest queries to facebook and queries to our db
    Koala::Utils.level = Logger::DEBUG
    Rails.logger.level = Logger::DEBUG

    unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
        raise 'Application id and/or secret are not specified in the environment'
    end

    log 'Crawling - give me some time please!'
    time_started = Time.now

    fb_crawling

    log "Crawling finished in #{Time.now - time_started}s :)"
end

def fb_crawling
    oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
    token = oauth.get_app_access_token
    crawler = FacebookCrawler.new(token)

    # Insert sources into DB
    groups_info = crawl_groups_info(crawler, FB_groups_to_track)
    insert_groups_sources(groups_info)

    pages_info = crawl_pages_info(crawler, FB_pages_to_track)
    insert_pages_sources(pages_info)

    crawl_groups_and_update(crawler)
    crawl_pages_and_update(crawler)
end

def crawl_groups_and_update(crawler)
    is_night_time = is_night Time.now

    FB_groups_to_track.each do |group|
        source = Source.find_by uid: group['id'], stype: 'group'

        next unless source.isOPEN
        feed, next_page = crawl_group(crawler, group, Feed_limit)

        loop do
            insert_events(feed[:events], source)
            insert_posts(feed[:posts], source)

            break if next_page.empty? || !is_night_time

            feed, next_page = crawler.prepare_feed next_page
        end # while
        # if
    end
end

def crawl_pages_and_update(crawler)
    FB_pages_to_track.each do |page|
        source = Source.find_by uid: page['id'], stype: 'page'

        page_events = crawl_page(crawler, page)
        insert_events(page_events)
    end
end

def crawl_groups_info(crawler, groups_to_track)
    log 'crawling info about groups'
    crawler.groups_info(groups_to_track)
end

def crawl_pages_info(crawler, pages_to_track)
    log 'crawling info about pages'
    crawler.pages_info(pages_to_track)
end

def crawl_group(crawler, group, feed_limit)
    log "downloading feed for group: #{group['name']}"
    feed = crawler.group_feed(group, feed_limit)
    log 'downloaded ' + feed.size.to_s + ' posts'

    feed
end

def crawl_page(crawler, page)
    log "downloading events from page: #{page['name']}"
    events = crawler.page_events(page)
    log 'downloaded ' + events.size.to_s + ' events'

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

def insert_events(events, source = nil)
    log 'inserting events into the database'

    event_uids_in_db = Event.pluck(:uid).to_set
    new_events = events.reject { |e| event_uids_in_db.include? e['id'] }

    new_events.each do |event_data|
        e = Event.from_fb_event(event_data) # TODO: - insert or update
        e.source = source
        e.save
    end

    log "crawled #{events.count} events, inserted #{new_events.count} new ones"
end

def insert_posts(posts, source = nil)
    log 'inserting posts into the database'

    # filter out existing posts
    post_uids_in_db = Post.pluck(:uid).to_set
    new_posts = posts.reject { |post| post_uids_in_db.include? post['id'] }

    new_posts.each do |post_data|
        post = Post.from_fb_post(post_data) # TODO: - insert or update
        post.source = source
        post.save
    end

    log "crawled #{posts.count} posts, inserted #{new_posts.count} new ones"
end

def log(message)
    puts "[ #{Time.now.strftime '%d/%m/%Y %H:%M:%S:%L'} ] - #{message}"
end

def is_night(date)
    !((5...23).cover? date.hour)
end
