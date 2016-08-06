require 'clockwork'

module Clockwork

  handler do |job, time|
    if job == "crawl"
      system "rake crawl"
    end
  end

  every(15.minutes, 'crawl')
  
end
