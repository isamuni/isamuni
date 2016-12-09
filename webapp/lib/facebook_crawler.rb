# frozen_string_literal: true
require 'koala'
require 'json'
require 'logger'

class FacebookCrawler
  Feed_fields = ['id', 'message', 'from', 'type',
                 'picture', 'link', 'created_time',
                 'updated_time', 'name', 'caption', 'description',
                 'shares', 'likes.summary(true)', 'comments.summary(true)'].freeze

  Event_fields = %w(id name description
                    start_time end_time updated_time
                    place parent_group owner).freeze

  Group_fields = %w(id name privacy icon).freeze

  Page_fields = %w(id name).freeze
  DEFAULT_PAGE_SIZE = 50

  # takes an options hash
  # :token => the facebook app token to use
  # :app_id, :app_secret => the app id and secret to use to get the token, if token is not given
  # :page_size => how many results to get with each call, defaults to 50
  # :logger => the logger to use (defaults to stderr)
  def initialize(options = {})
    # Obtain a facebook app token if not given
    if options[:token]
      token = options[:token]
    elsif options[:app_id] && options[:app_secret]
      oauth = Koala::Facebook::OAuth.new(options[:app_id], options[:app_secret], '')
      token = oauth.get_app_access_token
    else
      raise 'either token or app_id and app_secret should be defined'
    end

    @logger = if options[:logger]
                options[:logger]
              else
                Logger.new(STDERR)
              end

    # Change Koala logger to our same logger
    Koala::Utils.logger = @logger

    @graph = Koala::Facebook::API.new(token)
    @page_size = options[:page_size] || DEFAULT_PAGE_SIZE
  end

  def group_raw_feed(group_id, limit)
    options = { limit: limit, fields: Feed_fields }
    @graph.get_connection(group_id, 'feed', options)
  end

  # unused
  def group_members(group_id, limit)
    options = { limit: limit }
    @graph.get_connection(group_id, 'members', options)
  end

  def page_events(page_id)
    options = { fields: Event_fields }
    @logger.info "downloading events from page: #{page_id}"
    events = @graph.get_connection(page_id, 'events', options)
    @logger.info "downloaded #{events.size} events"
    events
  end

  # Get info about an event
  def event_info(event_id)
    @graph.get_object(event_id, fields: Event_fields)
  end

  # gets and processes 'limit' elements from a group with a given group_id
  # returns an enumerator, with each page of results
  def group_feed(group_id, limit)
    Enumerator.new do |y|
      processed = 0
      feed_page = group_raw_feed(group_id, @page_size)

      until feed_page.empty? || (processed >= limit)
        y << extract_feed_data(feed_page)

        processed += feed_page.length
        feed_page = feed_page.next_page
      end
    end
  end

  # Takes a raw feed, as obtained from a group or a page
  # partitions it in posts and events, also enriching each event with its details
  def extract_feed_data(feed)
    posts = feed.select do |fe|
      %w(status link photo event).include? fe['type']
    end

    events = feed.select { |fe| fe['type'] == 'event' }.map do |event|
      # This is a dirty way to get the id of the event
      # It is not possible to have /events call on the group
      # unless we have a user token (not for app tokens)
      event_id = event['link'][/events\/(.?)*\//][7..-2]
      event_info(event_id)
    end

    { posts: posts, events: events }
  end

  def group_info(group_id)
    @graph.get_object(group_id, fields: Group_fields)
  end

  def page_info(page_id)
    @graph.get_object(page_id, fields: Page_fields)
  end
end
