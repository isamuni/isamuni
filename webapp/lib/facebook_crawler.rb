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

  def initialize(token, page_size)
    @graph = Koala::Facebook::API.new(token)
    @page_size = page_size
  end

  def group_raw_feed group_id, limit
    options = { limit: limit, fields: Feed_fields }
    @graph.get_connection(group_id, 'feed', options)
  end

  # unused
  def group_members group_id, limit
    options = { limit: limit }
    @graph.get_connection(group_id, 'members', options)
  end

  def page_events page
    options = { fields: Event_fields }
    @graph.get_connection(page['id'], 'events', options)
  end

  # Get info about an event
  def event_info event_id
    @graph.get_object(event_id, { fields: Event_fields })
  end

  # gets and processes 'limit' elements from a group with a given group_id
  # returns an enumerator, with each page of results
  def group_feed group_id, limit
    Enumerator.new do |y|
      processed = 0
      feed_page = group_raw_feed(group_id, @page_size)

      until feed_page.empty? or processed >= limit
        y << extract_feed_data(feed_page)

        processed += feed_page.length
        feed_page = feed_page.next_page
      end

    end
  end

  # Takes a raw feed, as obtained from a group or a page
  # partitions it in posts and events, also enriching each event with its details
  def extract_feed_data feed

      posts = feed.select { |fe|
            ['status', 'link', 'photo', 'event'].include? fe['type'] }

      events = feed.select{ |fe| fe['type'] == 'event'}.map do |event|
          # This is a dirty way to get the id of the event
          # It is not possible to have /events call on the group
          # unless we have a user token (not for app tokens)
          event_id = event['link'][/events\/(.?)*\//][7..-2]
          event_info(event_id)
      end

      {posts: posts, events: events}
  end

  def groups_info groups
    groups.flat_map {|group| @graph.get_object(group['id'], {fields: Group_fields}) }
  end

  def pages_info pages
    pages.flat_map {|page| @graph.get_object(page['id'], {fields: Page_fields}) }
  end

end
