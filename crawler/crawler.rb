require 'active_record'
require 'sqlite3' # or 'mysql2', pg' or 'sqlite3'
require 'friendly_id'

Dir.glob('../webapp/app/models/*.rb', &method(:require))
require './lib/crawler.rb'

# As in: http://stackoverflow.com/questions/1643875/how-to-use-activerecord-in-a-ruby-script-outside-rails
# Change the following to reflect your database settings
ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3', # 'mysql2', or 'postgresql' or 'sqlite3'
  # host:     'localhost',
  database: '../webapp/db/development.sqlite3'
  #username: 'your_username',
  #password: 'your_password'
)

# Test queries:
# puts ActiveRecord::Base.connection.tables
# puts User.all.collect(&:name)

Sleep_default_time = 5 * 60 # 5 minutes - time is in seconds
Group_to_track = 281460675321367 # Track posts of this group. This is the id for the group Programmatori a Catania
Pages_to_track = [
    116505148430596,  # YoutHub
    371576386279313,  # EESTEC Catania
    1486797638277248  # CoderDojo Etneo
    ] # track events only
Feed_limit = 1000 # No need to have this very high, except for the first time

while true
  puts "crawling"

  unless @token
    @token = Crawler.oauth.get_app_access_token
    @graph = Koala::Facebook::API.new(@token)
  end

  since = Crawler.check_database_for_latest
  feed = Crawler.feed @graph, Group_to_track, Feed_limit, since
  events = Crawler.events @graph, Pages_to_track # use also since?

  if false # TODO - Check feed for errors
    @token = nil
    next
  else
    Crawler.populate_database_feed @graph, feed
    Crawler.populate_database_events @graph, events

    puts "crawling done, will check again in 5 minutes"
    sleep Sleep_default_time # Put the crawler to sleep, to avoid too many calls on the FB API
  end


end # end of while loop
