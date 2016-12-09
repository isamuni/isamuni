# frozen_string_literal: true
require 'facebook_crawler'
require 'yaml'
require 'date'

config = YAML.load_file('crawler_config.yml')

FB_groups_to_track = config['fb']['groups']
FB_pages_to_track = config['fb']['pages']

desc 'Crawls events and posts from the given set of pages and insert the result into the database'
task :crawl, [:complete] => :environment do |_t, args|
  args.with_defaults(complete: false)

  complete_crawling = args[:complete]
  feed_limit = complete_crawling ? 2000 : 50

  Rails.logger.level = Logger::DEBUG if Rails

  unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
    raise 'Application id and/or secret are not specified in the environment'
  end

  log 'Crawler started, initializing'
  time_started = Time.now

  fb_crawling ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], feed_limit

  log "Crawling finished in #{Time.now - time_started}s :)"
end

def fb_crawling(app_id, app_secret, feed_limit)
  crawler = FacebookCrawler.new(app_id: app_id, app_secret: app_secret)

  # Insert sources into DB
  log 'crawling info about groups'
  FB_groups_to_track.each do |group|
    group_data = crawler.group_info(group['id'])
    Source.from_fb_group(group_data).save
  end

  log 'crawling info about pages'
  FB_pages_to_track.each do |page|
    page_data = crawler.page_info(page['id'])
    Source.from_fb_page(page_data).save
  end

  log 'crawling group feed'
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

  log 'crawling page feed'
  FB_pages_to_track.each do |page|
    source = Source.find_by uid: page['id'], stype: 'page'
    page_events = crawler.page_events(page['id'])
    insert_events(page_events, source)
  end
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
