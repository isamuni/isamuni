require 'crawler'
require 'yaml'

config = YAML.load_file('crawler_config.yml')

Group_to_track = config['group'] # Track posts of this group. This is the id for the group Programmatori a Catania
Pages_to_track = config['pages'] # track events only

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


  # Downloading

  time_started = Time.now

  puts "Crawling - give me some time please!"

  puts "downloading and saving allowed users"
  allowed_users = crawler.group_members(Group_to_track, Members_limit)
  allowed_users.each do |user|
    Alloweduser.from_fb_users(Group_to_track, user).save
  end
  puts "saved #{allowed_users.count} allowed users"

  puts "downloading group feed"
  since = Post.last_post_date
  feed = crawler.group_feed(Group_to_track, Feed_limit, since)

  puts "downloading page events"
  page_events = crawler.page_events(Pages_to_track, Feed_limit)

  # Saving

  puts "saving events"
  events = feed[:events] + page_events

  event_uids_in_db = Event.pluck(:uid).to_set
  new_events = events.reject { |e| event_uids_in_db.include? e['id'] } 
  
  new_events.each do |e|
    Event.from_fb_event(e).save 
  end

  puts "crawled #{events.count} events, inserted #{new_events.count} new ones"


  puts "saving posts"
  
  posts = feed[:posts]

  post_uids_in_db = Post.pluck(:uid).to_set
  new_posts = posts.reject { |post| post_uids_in_db.include? post['id']}

  new_posts.each do |post|
    Post.from_fb_post(post).save!
  end

  puts "crawled #{posts.count} posts, inserted #{new_posts.count} new ones"


  puts "Crawling finished in #{Time.now - time_started}s :)"

end
