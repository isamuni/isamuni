require 'FacebookCrawler'

class CrawlerJob < ApplicationJob
  queue_as :default

  def initialize
    @crawler = ::FB::Crawler.new(app_id: ENV['ISAMUNI_APP_ID'], app_secret: ENV['ISAMUNI_APP_SECRET'])    
  end

  def crawlGroup(source)
    n_posts = 0
    n_events = 0

    feed = @crawler.group_feed(source.uid)

    feed.each do |element|

      if element.post?
        post = Post.from_fb_post(element)
        post.source = source
        post.save!
        n_posts += 1
      end

      elinks = element.event_links

      if elinks.key? 'fb'
        einfo = @crawler.event_info(elinks['fb'])
        einfo.area_str
        e = Event.from_fb_event(einfo)
        e.source = source
        e.save!
        n_events += 1
      end

    end

    logger.info "group #{source.name}: inserted/updated #{n_posts} posts, #{n_events} events"
  end

  def crawlPage(source)
    n_events = 0
    
    page_events = @crawler.page_events(source.uid)

    page_events.each do |element|
      e = Event.from_fb_event(element)
      e.source = source
      e.save!
      n_events += 1
    end

    logger.info "page #{source.name}: inserted/updated #{n_events} events"
  end

  def perform
    logger.info 'crawling sources'
    Source.where.not(status: :disabled).each do |source|
      logger.info "crawling source: #{source.name}"
      
      begin
        if source.stype == 'group'
          crawlGroup(source)
        elsif source.stype == 'page'
          crawlPage(source)
        else
          raise "Unknown source type"
        end
        
        source.status = 'working'
        source.message = ""
        
      rescue => e
        
        source.status = 'failing'  
        source.message = e.message
        logger.info "error while processing source #{source.id}:" + e.message
      end

      #source.lastCrawled = Time.now
      source.save!

    end

    logger.info 'Done'
  end
end
