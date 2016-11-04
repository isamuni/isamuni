require 'crawler'
require 'yaml'

config = YAML.load_file('crawler_config-1.yml')

Groups_to_track = config['fb']['groups'] # Track posts of this group. This is the id for the group Programmatori a Catania
Pages_to_track = config['fb']['pages'] # track events only

Feed_limit = 10000 # No need to have this very high, except for the first time
Members_limit = 10000

# TODO - change for production
Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback"

desc "Crawls events and posts from the given set of pages and insert the result into the database"
task :crawl => :environment do

  puts "Crawler started, initializing"

  unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
    raise "Application id and/or secret are not specified in the environment"
  end

  oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
  token = oauth.get_app_access_token
  puts token
  crawler = crawler = Crawler.new(token)

  puts "Crawling - give me some time please!"

  time_started = Time.now
  feed = nil
  page_events = nil

  since = Post.last_post_date

  feed = crawl_groups(crawler, Groups_to_track, Feed_limit, since)
  events = feed[:events] + crawl_pages(crawler, Pages_to_track, Feed_limit)
  posts = feed[:posts]

  insert_events(events)
  insert_posts(posts)

  crawling_duration = Time.now - time_started
  puts "Crawling finished in #{crawling_duration}s :)"

end

def crawl_groups crawler, groups_to_track, feed_limit, since
  puts "-downloading group feed"
  feed = crawler.groups_feed(groups_to_track, feed_limit, since)
  puts "-downloaded " + feed.size.to_s + " posts"

  feed
end

def crawl_pages crawler, pages_to_track, feed_limit
  puts "-downloading page events"
  events = crawler.page_events(pages_to_track, feed_limit)
  puts "-downloaded " + events.size.to_s + " events"

  events
end

def insert_events events
  puts "-inserting events into the database"
  number_events = 0
  events.each do |event|
    unless Event.exists?(uid: event['id'])
      Event.from_fb_event(event).save
      number_events += 1
    end
  end
  puts "-just inserted " + number_events.to_s + " events"
end

def insert_posts posts
  puts "-inserting posts into the database"
  number_posts = 0
  posts.each do |post|
    unless Post.exists?(uid: post['id'])
      Post.from_fb_post(post).save!
      number_posts += 1
    end
  end
  puts "-just inserted " + number_posts.to_s + " posts"
end