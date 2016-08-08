require_relative 'webapp/lib/crawler'
require 'optparse'
require 'json'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-s", "--since [SINCE]", "Only crawl posts after this date (yyyy-mm-dd)") do |v|
    options[:since] = since
    #todo enforce format
  end

end.parse!

Group_to_track = 281460675321367 # Track posts of this group. This is the id for the group Programmatori a Catania
Pages_to_track = [
    116505148430596,  # YoutHub
    371576386279313,  # EESTEC Catania
    1486797638277248, # CoderDojo Etneo
    887171771350676,  # ATFactory
    1457341927813814, # Hackspacee Catania
    859949567453237,  # MPS Catania
    1380906508817529, # Startup Messina
    146290095529300,  # Consorzio Arca
    444735402236013,  # GDG Catania
    875340082514949,  # Vulcanic
    150423961659353,  # Impact Hub Siracusa
    189873531201389   # Fablab CT
    ] # track events only
Feed_limit = 1000 # No need to have this very high, except for the first time
Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback"

STDERR.puts "Crawler started, initializing"

unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
  raise "Application id and/or secret are not specified in the environment"
end

oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
token = oauth.get_app_access_token
crawler = crawler = Crawler.new(token)

STDERR.puts "Crawling - give me some time please!"

time_started = Time.now
feed = nil
page_events = nil

since = options[:since] || nil

STDERR.puts "downloading group feed"
feed = crawler.group_feed(Group_to_track, Feed_limit, since)

STDERR.puts "downloading page events"
events = feed[:events] + crawler.page_events(Pages_to_track, Feed_limit)
posts = feed[:posts]

STDERR.puts "inserting events into the database"
events.each do |event|
  puts event.to_json
end

STDERR.puts "inserting posts into the database"
posts.each do |post|
  puts post.to_json
end

crawling_duration = Time.now - time_started
STDERR.puts "Crawling finished in #{crawling_duration}s :)"
