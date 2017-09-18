require 'config/boot'
require 'config/environment'

every(1.hour, 'crawl') { CrawlerJob.perform_now }