require 'crawler'
require 'yaml'

config = YAML.load_file('crawler_config.yml')

Group_to_track = config['group'] # Track posts of this group. This is the id for the group Programmatori a Catania
Pages_to_track = config['pages'] # track events only

Feed_limit = 1000 # No need to have this very high, except for the first time

Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback"

desc "Crawls events and posts from the given set of pages and insert the result into the database"
task :crawl => :environment do

  puts "Crawler started, initializing"

  unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
    raise "Application id and/or secret are not specified in the environment"
  end

  oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
  token = oauth.get_app_access_token
  crawler = crawler = Crawler.new(token)

  puts "Crawling - give me some time please!"

  time_started = Time.now
  feed = nil
  page_events = nil

  since = Post.last_post_date

  puts "downloading group feed"
  feed = crawler.group_feed(Group_to_track, Feed_limit, since)

  puts "downloading page events"
  events = feed[:events] + crawler.page_events(Pages_to_track, Feed_limit)
  posts = feed[:posts]

  puts "inserting events into the database"
  events.each do |event|
    unless Event.exists?(uid: event['id'])
      Event.from_fb_event(event).save
    end
  end

  puts "inserting posts into the database"
  posts.each do |post|
    unless Post.exists?(uid: post['id'])
      Post.from_fb_post(post).save!
    end
  end

  crawling_duration = Time.now - time_started
  puts "Crawling finished in #{crawling_duration}s :)"

end
