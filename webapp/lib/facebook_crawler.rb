require 'koala'
require 'json'

class FacebookCrawler

  Feed_fields = ['id', 'message', 'from', 'type',
                  'picture', 'link', 'created_time',
                  'updated_time', 'name', 'caption', 'description',
                  'shares', 'likes.summary(true)', 'comments.summary(true)']

  Event_fields = ['id', 'name', 'description',
                  'start_time', 'end_time', 'updated_time',
                  'place', 'parent_group', 'owner']

  Group_fields = ['id', 'name', 'privacy', 'icon']

  Page_fields = ['id', 'name']

  def initialize(token)
    @graph = Koala::Facebook::API.new(token)
  end

  def group_raw_feed group, limit
    options = { limit: limit, fields: Feed_fields }
    @graph.get_connection(group['id'], 'feed', options)
  end

  def group_members groupid, limit
    options = { limit: limit }
    @graph.get_connection(groupid, 'members', options)
  end

  def page_events page
    options = { fields: Event_fields }
    @graph.get_connection(page['id'], 'events', options)
  end

  # Get info about an event
  def event_info event_id
    @graph.get_object(event_id, { fields: Event_fields })
  end

  def group_feed group, limit
    feed = group_raw_feed(group, limit)
    prepare_feed feed
  end

  def prepare_feed feed

    posts = feed.select { |fe|
          ['status', 'link', 'photo', 'event'].include? fe['type'] }

    events = feed.select{ |fe| fe['type'] == 'event'}.map do |event|
        # This is a dirty way to get the id of the event
        # It is not possible to have /events call on the group
        # unless we have a user token (not for app tokens)
        event_id = event['link'][/events\/(.?)*\//][7..-2]
        event_info(event_id)
      end

    return {posts: posts, events: events}, feed.next_page
  end

  def groups_info groups
    groups.flat_map {|group| @graph.get_object(group['id'], {fields: Group_fields}) }
  end

  def pages_info pages
    pages.flat_map {|page| @graph.get_object(page['id'], {fields: Page_fields}) }
  end

end
