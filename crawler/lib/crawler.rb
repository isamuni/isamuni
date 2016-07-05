require 'koala'
require 'json'

Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback" # Auth callback of your application
Feed_fields = ['id', 'message', 'from', 'type',
                'picture', 'link', 'created_time', 'updated_time']
Event_fields = ['id', 'name', 'description', 'start_time', 'end_time', 'updated_time',
                'place']
Job_tags = ['#lavoro', '#jobs', '#job', '#cercosocio']

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
  def Crawler.feed graph, id, limit, since=nil
    options = { limit: limit, fields: Feed_fields }

    if defined? since
      options[:since] = since # Use this if there are posts in the DB (using date from latest post)
    end

    posts = graph.get_connection(id, 'feed', options)
  end

  def Crawler.events graph, pages
    options = { fields: Event_fields }

    if defined? since
      options[:since] = since # Use this if there are posts in the DB (using date from latest post)
    end

    events = []
    pages.each do | id |
      page_events = graph.get_connection(id, 'events', options)
      
      page_events.each do | page_event |
        events.push page_event
      end
    end

    return events
  end


  # Get info about an event
  def Crawler.get_event graph, id
    return graph.get_object(id, { fields: Event_fields })
  end

  def Crawler.add_event fb_event
    
    event = Event.new()
    event.uid = fb_event['id']
    event.name = fb_event['name']
    event.content = fb_event['description']
    event.starts_at = fb_event['start_time']
    event.ends_at = fb_event['end_time']

    if fb_event['place'] != nil
      event.location = fb_event['place']['name']
    end

    event.save!
  end


  # Get date (yyyy-mm-dd) of the latest post in the db
  def Crawler.check_database_for_latest
    last_post_date = Post.maximum(:created_at)
    if last_post_date != nil 
      last_post_date.strftime("%Y-%m-%d")
    end
  end

  def Crawler.add_post feed_post

    post = Post.new()
    post.uid = feed_post['id']
    post.content = feed_post['message']
    post.author_name = feed_post['from']['name']
    post.author_uid = feed_post['from']['id']
    post.created_at = feed_post['created_time']
    post.updated_at = feed_post['updated_time']
    post.post_type = feed_post['type']
    if feed_post['link'] != nil
      post.link = feed_post['link']
    end

    if post.content != nil
      jobs = Job_tags.any? { |word| post.content.downcase.include?(word) }
      if jobs
        post.tags = 'job' # Improve?
      end
    end

    post.save!
  end

  # Add the posts in the feed to the database
  # Params:
  # +feed+:: feed of posts
  def Crawler.populate_database_feed graph, feed

    events = []
    feed.each do | feed_post |
      
      case feed_post['type'] 
      when 'status', 'link', 'photo'
        if Post.exists?(uid: feed_post['id']) 
          next
        end
        add_post feed_post

      when 'event' 
        if Event.exists?(uid: feed_post['id'])
          next
        end

        # This is a dirty way to get the id of the event
        # It is not possible to have /events call on the group
        # unless we have a user token (not for app tokens)
        event_id = feed_post['link'][/events\/(.?)*\//][7..-2]
        events.push event_id
        
      end
    end

    events.each do | event_id |
      event = get_event graph, event_id
      add_event event
    end
  end

  def Crawler.populate_database_events graph, events
    
    events.each do | event |
      if Event.exists?(uid: event['id'])
        next
      end

      add_event event
    end

  end
  
end
