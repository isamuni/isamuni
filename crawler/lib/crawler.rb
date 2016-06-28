require 'koala'
require 'json'

Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback" # Auth callback of your application
Feed_fields = ['message', 'id', 'from', 'type',
                'picture', 'link', 'created_time', 'updated_time']

class Crawler  
  
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
  def Crawler.check_database_for_latest
    last_post_date = Post.maximum(:created_at)
    last_post_date.strftime("%Y-%m-%d")
  end

  # Add the posts in the feed to the database
  # Params:
  # +feed+:: feed of posts
  def Crawler.populate_database(feed)
    puts "Here I will be populating the DB"
    # puts feed
    feed.each do | feed_post |
      if Post.exists?(uid: feed_post['id'])
        next
      end

      post = Post.new()
      post.uid = feed_post['id']
      post.content = feed_post['message']
      post.author_name = feed_post['from']['name']
      post.author_uid = feed_post['from']['id']
      post.created_at = feed_post['created_time']
      post.updated_at = feed_post['updated_time']
      post.save!
    end
  end
  
end
