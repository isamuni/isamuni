require 'crawler'
require 'yaml'

config = YAML.load_file('crawler_config.yml')

Groups_to_track = config['fb']['groups']
Pages_to_track = config['fb']['pages'] # we'll only track events

Feed_limit = 10000 # No need to have this very high, except for the first time
Members_limit = 10000

Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback"

desc "Crawls events and posts from the given set of pages and insert the result into the database"
task :crawl => :environment do

  puts "Crawler started, initializing"

  # Setting logger level, so we have a log of both rest queries to facebook and queries to our db
  Koala::Utils.level = Logger::DEBUG
  Rails.logger.level = Logger::DEBUG

  unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
    raise "Application id and/or secret are not specified in the environment"
  end

  oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
  token = oauth.get_app_access_token
  crawler = crawler = Crawler.new(token)

  log "Crawling - give me some time please!"
  time_started = Time.now

  # Insert sources into DB
  groups_info = crawl_groups_info(crawler, Groups_to_track)
  insert_sources(groups_info)

  # Download feed from each group
  Groups_to_track.each do |group|
    source = Source.find_by uid: group['id']
    since = source.posts.last_post_date
    feed = crawl_group(crawler, group, Feed_limit, since)

    insert_events(feed[:events], source)
    insert_posts(feed[:posts], source)
  end

  # Download events from each page
  Pages_to_track.each do |page|

    # TODO  
    # source = Source.find_by uid: page['id']
    # since = source.posts.last_post_date
    
    page_events = crawl_page(crawler, page, Feed_limit)
    insert_events(page_events)
  end

  log "Crawling finished in #{Time.now - time_started}s :)"
end

def crawl_groups_info crawler, groups_to_track
  log "crawling info about groups"
  crawler.groups_info(groups_to_track)
end

def crawl_group crawler, group, feed_limit, since
  log "downloading group feed"
  feed = crawler.group_feed(group, feed_limit, since)
  log "downloaded " + feed.size.to_s + " posts"

  feed
end

def crawl_page crawler, page, feed_limit
  log "downloading page events"
  events = crawler.page_events(page, feed_limit)
  log "downloaded " + events.size.to_s + " events"

  events
end

def insert_sources groups
  log "inserting info about groups"

  groups.each do |group|
    Source.from_fb_source(group).save
  end

  log "all info added/updated"
end


def insert_events events, source=nil
  log "inserting events into the database"
  
  event_uids_in_db = Event.pluck(:uid).to_set
  new_events = events.reject { |e| event_uids_in_db.include? e['id'] } 

  new_events.each do |event_data|
    e = Event.from_fb_event(event_data)
    e.source = source
    e.save
  end

  log "crawled #{events.count} events, inserted #{new_events.count} new ones"
end

def insert_posts posts, source=nil
  log "inserting posts into the database"

  # filter out existing posts
  post_uids_in_db = Post.pluck(:uid).to_set
  new_posts = posts.reject { |post| post_uids_in_db.include? post['id']}

  new_posts.each do |post_data|
    post = Post.from_fb_post(post_data)
    post.source = source
    post.save
  end
  
  log "crawled #{posts.count} posts, inserted #{new_posts.count} new ones"
end

def log message
  puts "[ #{Time.now.strftime '%d/%m/%Y %H:%M:%S:%L'} ] - #{message}"
end
