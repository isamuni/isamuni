require 'koala'
require 'json'

Callback_url = "http://squirrels.vii.ovh/auth/facebook/callback" # Auth callback of your application
Feed_fields = ['id', 'message', 'from', 'type',
                'picture', 'link', 'created_time', 'updated_time']
Event_fields = ['id', 'name', 'description', 'start_time', 'end_time', 'updated_time',
                'place', 'category']

class Crawler

  # Authenticate the registered Facebook App and return an oauth Koala object
  def Crawler.oauth
    unless ENV['ISAMUNI_APP_ID'] && ENV['ISAMUNI_APP_SECRET']
      raise "Application id and/or secret are not specified in the environment"
    end
    oauth = Koala::Facebook::OAuth.new(ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET'], Callback_url)
  end

  # Get a feed of posts from a given Facebook group
  # Params:
  # +graph+:: Koala graph used to make queries on the FB graph API
  # +id+:: of the group
  # +limit+:: number of maximum posts to query for
  # +since+:: (optional) query all the posts since this date (yyyy-mm-dd)
  def Crawler.feed graph, id, limit, since=nil
    options = { limit: limit, fields: Feed_fields }

    options[:since] = since if since # Use this if there are posts in the DB (using date from latest post)
    posts = graph.get_connection(id, 'feed', options)
  end

  def Crawler.events graph, pages, since=nil
    options = { fields: Event_fields }

    options[:since] = since if since # Use this if there are posts in the DB (using date from latest post)

    events = pages.flat_map {|id| graph.get_connection(id, 'events', options)}
  end


  # Get info about an event
  def Crawler.get_event graph, id
    return graph.get_object(id, { fields: Event_fields })
  end

  # Get date (yyyy-mm-dd) of the latest post in the db
  def Crawler.check_database_for_latest
    last_post_date = Post.maximum(:created_at)
    if last_post_date != nil
      last_post_date.strftime("%Y-%m-%d")
    end
  end

  # Add the posts in the feed to the database
  # Params:
  # +feed+:: feed of posts
  def Crawler.populate_database_feed graph, feed

    events = []
    feed.each do | feed_post |

      case feed_post['type']

      when 'status', 'link', 'photo', 'event'
        unless Post.exists?(uid: feed_post['id'])
          Post.from_fb_post(feed_post).save!
        end


      when 'event'
        unless Event.exists?(uid: feed_post['id'])
          # This is a dirty way to get the id of the event
          # It is not possible to have /events call on the group
          # unless we have a user token (not for app tokens)
          event_id = feed_post['link'][/events\/(.?)*\//][7..-2]
          events.push event_id
        end
      end
    end

    events.each do | event_id |
      event = get_event graph, event_id
      Event.from_fb_event(event).save
    end
  end

  def Crawler.populate_database_events graph, events
    events.each do | event |
      unless Event.exists?(uid: event['id'])
        Event.from_fb_event(event).save
      end
    end
  end


end
