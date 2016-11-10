require 'crawler'
require 'yaml'

config = YAML.load_file('crawler_config-1.yml')

Groups_to_track = config['fb']['groups'] # Track posts of this group. This is the id for the group Programmatori a Catania
Pages_to_track = config['fb']['pages'] # track events only

Feed_limit = 10000 # No need to have this very high, except for the first time
Members_limit = 10000

Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback"

desc "Crawls events and posts from the given set of pages and insert the result into the database"
task :crawl => :environment do

  puts "Crawler started, initializing"
  Koala::Utils.level = Logger::DEBUG

  unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
    raise "Application id and/or secret are not specified in the environment"
  end

  oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
  token = oauth.get_app_access_token
  crawler = crawler = Crawler.new(token)

  log "Crawling - give me some time please!"

  time_started = Time.now
  feed = nil
  page_events = nil
  since = Post.last_post_date # Must be custom for each group/page

  groups_info = crawl_groups_info(crawler, Groups_to_track)
  insert_groups_info(groups_info)

  feed = crawl_groups(crawler, Groups_to_track, Feed_limit, since)
  page_events = crawl_pages(crawler, Pages_to_track, Feed_limit)
  events = feed[:events] + page_events
  posts = feed[:posts]

  insert_events(events)
  insert_posts(posts)

  crawling_duration = Time.now - time_started
  log "Crawling finished in #{crawling_duration}s :)"
end

def crawl_groups_info crawler, groups_to_track
  log "crawling info about groups"
  groups_info = crawler.groups_info(groups_to_track)

  groups_info
end

def crawl_groups crawler, groups_to_track, feed_limit, since
  log "downloading group feed"
  feed = crawler.groups_feed(groups_to_track, feed_limit, since)
  log "downloaded " + feed.size.to_s + " posts"

  feed
end

def crawl_pages crawler, pages_to_track, feed_limit
  log "downloading page events"
  events = crawler.page_events(pages_to_track, feed_limit)
  log "downloaded " + events.size.to_s + " events"

  events
end

def insert_groups_info groups
  log "inserting info about groups"

  groups.each do |group|
    CrawlerSource.from_fb_source(group).save
  end

  log "all info added/updated"
end


def insert_events events
  log "inserting events into the database"
  
  event_uids_in_db = Event.pluck(:uid).to_set
  new_events = events.reject { |e| event_uids_in_db.include? e['id'] } 
  new_events.each do |event|
    Event.from_fb_event(event).save 
  end

  log "crawled #{events.count} events, inserted #{new_events.count} new ones"
end

def insert_posts posts
  log "inserting posts into the database"

  post_uids_in_db = Post.pluck(:uid).to_set
  new_posts = posts.reject { |post| post_uids_in_db.include? post['id']}
  new_posts.each do |post|
    Post.from_fb_post(post).save!
  end
  
  log "crawled #{posts.count} posts, inserted #{new_posts.count} new ones"
end

def log message
  puts "[ " + Time.now.strftime("%d/%m/%Y %H:%M:%S:%L") + " ] - " + message
end
