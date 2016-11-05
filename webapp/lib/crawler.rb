require 'koala'
require 'json'

class Crawler

  Feed_fields = ['id', 'message', 'from', 'type',
                  'picture', 'link', 'created_time', 
                  'updated_time', 'name', 'caption', 
                  'description']
                  # Use the fields below to get info on number of:
                  # likes, shares, comments
                  # 'shares', 'likes.summary(true)', 'likes.summary(true)'

  Event_fields = ['id', 'name', 'description', 
                  'start_time', 'end_time', 'updated_time',
                  'place', 'parent_group', 'owner']

  Group_fields = ['id', 'name', 'privacy', 'icon']

  def initialize(token)
    @graph = Koala::Facebook::API.new(token)
  end

  def groups_raw_feed groups, limit, since=nil
    options = { limit: limit, fields: Feed_fields, since: since }

    puts options

    # Not needed - using it for debugging
    groups.each do |group|
      puts group['id']
      res = @graph.get_connection(group['id'], 'feed', options)
      puts res.size
    end

    groups.flat_map {|group| @graph.get_connection(group['id'], 'feed', options) }
  end

  def group_members groupid, limit
    options = { limit: limit }
    @graph.get_connection(groupid, 'members', options)
  end    

  def page_events pages, since=nil
    options = { fields: Event_fields, since: since }
    pages.flat_map {|page| @graph.get_connection(page['id'], 'events', options)}
  end

  # Get info about an event
  def event_info event_id
    @graph.get_object(event_id, { fields: Event_fields })
  end

  def groups_feed groups, limit, since
    feed = groups_raw_feed(groups, limit, since)

    posts = feed.select { |fe|
          ['status', 'link', 'photo', 'event'].include? fe['type'] }

    events = feed.select{ |fe| fe['type'] == 'event'}.map do |event|
        # This is a dirty way to get the id of the event
        # It is not possible to have /events call on the group
        # unless we have a user token (not for app tokens)
        event_id = event['link'][/events\/(.?)*\//][7..-2]
        event_info(event_id)
      end

    return {posts: posts, events: events}
  end

  def groups_info groups
    groups.flat_map {|group| @graph.get_object(group['id'], {fields: Group_fields}) }
  end

end
