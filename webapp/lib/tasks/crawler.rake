namespace :crawler do

    desc 'Crawl fb sources'
    task :crawl_fb, [:complete] => :environment do |_t, args|
        Rails.logger = Logger.new(STDOUT)
        CrawlerJob.new.perform
    end
end