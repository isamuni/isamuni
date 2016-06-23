require "crawler/version"
require 'koala'

Sleep_default_time = 10 # in seconds
Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback"
Group_to_track = 281460675321367
Feed_limit = 1000 # No need to have this much, except for the first time


module Crawler  
  
  def self.oauth
  	raise "application id and/or secret are not specified in the envrionment" unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
  	@oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
  end


  def self.feed(graph, id, limit)
    posts = graph.get_connection(id, 'feed',
            {limit: limit,
              fields: ['message', 'id', 'from', 'type',
                        'picture', 'link', 'created_time', 'updated_time'
                ]})
  end

  while true
    if !defined? @token
      @token = oauth.get_app_access_token 
    end

    graph = Koala::Facebook::API.new(@token)
    if !defined? graph
      @token = nil
      next
    end

    feed = feed(graph, Group_to_track, Feed_limit)

    sleep Sleep_default_time # Put the crawler to sleep, to avoid too many calls on the FB API 
  end
  
end

