require 'koala'

module FB
    
    class DObj
      extend Forwardable
      def_delegators :@h, :[], :dig
    
      def initialize(h = {})
        @h = h
      end
    end
    
    class Post < DObj
      FIELDS = ['id', 'message', 'from', 'type',
               'picture', 'link', 'created_time',
               'updated_time', 'name', 'caption', 'description',
               'shares', 'likes.summary(true)', 'comments.summary(true)'].freeze
  
      def event_links()
        links = {}
        element = @h
        %w(link message description caption).each do |s|
          links['fb'] ||= extract_facebook_id(element[s]) if element['type'] == 'event' 
          links['eventbrite'] ||= extract_eventbrite_id(element[s])
        end
  
        links.reject!{|k,v| v.nil?}
        links
      end
      
      def post?()
        %w(status link photo event).include? @h['type']
      end
  
      def extract_facebook_id(text)
        /facebook.com\/events\/(\d+)/.match(text)&.[](1)
      end
    
      def extract_eventbrite_id(text)
        /eventbrite\.(?:it|com)\/e\/[\w-]+-(\d+)/.match(text)&.[](1)
      end
    end
  
    class Event < DObj
      FIELDS = %w(id name description
                start_time end_time updated_time
                place parent_group owner).freeze
      
      # returns a string containing the city
      def area_str()
        @h.dig('place', 'location', 'city') || @h.dig('place', 'name')
      end
    end
  
    class Group < DObj
      FIELDS = %w(id name privacy icon).freeze
    end
  
    class Page < DObj
      FIELDS = %w(id name).freeze
    end
  
    class Crawler  
      DEFAULT_PAGE_SIZE = 50
  
      def get_token(app_id, app_secret)
        raise 'either a token or app_id and app_secret should be defined' unless app_id and app_secret
        oauth = Koala::Facebook::OAuth.new(app_id, app_secret, '')
        oauth.get_app_access_token
      end

      # takes an options hash
      # :token => the facebook app token to use
      # :app_id, :app_secret => the app id and secret to use to get the token, if token is not given
      # :page_size => how many results to get with each call, defaults to 50
      # :logger => the logger to use (defaults to stderr)
      def initialize(options = {})
        @logger = options[:logger] || Logger.new(STDERR)
        Koala::Utils.logger = @logger
  
        token = options[:token] || get_token(options[:app_id],options[:app_secret])
        @graph = Koala::Facebook::API.new(token)
        @page_size = options[:page_size] || DEFAULT_PAGE_SIZE
      end
  
      # unused
      def group_members(group_id, limit)
        options = { limit: limit }
        @graph.get_connection(group_id, 'members', options)
      end
  
      def page_events(page_id)
        options = { fields: Event::FIELDS }
        @logger.info "downloading events from page: #{page_id}"
        events = @graph.get_connection(page_id, 'events', options)
        @logger.info "downloaded #{events.size} events"
        events.map {|a| Event.new(a) }
      end
      
      def group_raw_feed(group_id, limit)
        options = { limit: limit, fields: Post::FIELDS }
        @graph.get_connection(group_id, 'feed', options)
      end
  
      # gets and processes 'limit' elements from a group with a given group_id
      # returns an enumerator with the resulting elements
      def group_feed(group_id, limit=@page_size)
        Enumerator.new do |y|
          processed = 0
          current_page = group_raw_feed(group_id, @page_size)
  
          until current_page.empty? || (processed >= limit)
            current_page.each do |element|
              y << Post.new(element)
              processed = processed + 1
            end
            current_page = current_page.next_page
          end
        end
      end
  
      def group_info(group_id)
        Group.new @graph.get_object(group_id, fields: Group::FIELDS)
      end
  
      def page_info(page_id)
        Page.new @graph.get_object(page_id, fields: Page::FIELDS)
      end
  
      def event_info(event_id)
        Event.new @graph.get_object(event_id, fields: Event::FIELDS)
      end
  
      def log(message)
        puts "[#{Time.now.strftime '%d/%m/%Y %H:%M:%S:%L'}] #{message}"
      end

    end
  end