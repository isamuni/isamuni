require "crawler/version"
require 'koala'

Sleep_default_time = 5 * 60 # 5 minutes - time is in seconds
Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback" # Auth callback of your application
Group_to_track = 281460675321367 # this is the id for the group Programmatori a Catania
Feed_limit = 1000 # No need to have this very high, except for the first time
Feed_fields = ['message', 'id', 'from', 'type',
                'picture', 'link', 'created_time', 'updated_time']

module Crawler  
  
  # Authenticate the registered Facebook App and return an oauth Koala object
  def Crawler.oauth
  	raise "Application id and/or secret are not specified in the envrionment" unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
  	@oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
  end

  # Get a feed of posts from a given Facebook group
  # Params:
  # +graph+:: Koala graph used to make queries on the FB graph API
  # +id+:: of the group
  # +limit+:: number of maximum posts to query for
  # +since+:: (optional) query all the posts since this date (yyyy-mm-dd)
  def Crawler.feed(graph, id, limit, since=nil)
    options = { limit: limit, fields: Feed_fields }

    if defined? since
      options[:since] = since # Use this if there are posts in the DB (using date from latest post)
    end

    posts = graph.get_connection(id, 'feed', options)
  end

  # Get date (yyyy-mm-dd) of the latest post in the db
  def Crawler.checkDatabaseForLatest
    puts "Here I will look for the date (yyyy-mm-dd) of the latest stored post or return nothing if DB is empty"
  end

  # Add the posts in the feed to the database
  # Params:
  # +feed+:: feed of posts
  def Crawler.populateDatabase(feed)
    puts "Here I will be populating the DB"
  end

  while true
    if !defined? @token
      @token = oauth.get_app_access_token 
      @graph = Koala::Facebook::API.new(@token)
    end

    since = checkDatabaseForLatest
    feed = feed @graph, Group_to_track, Feed_limit, since

    if false # Check feed for errors
      @token = nil
      next
    else
      populateDatabase feed
      sleep Sleep_default_time # Put the crawler to sleep, to avoid too many calls on the FB API 
    end
    
  end # end of while loop
  
end
