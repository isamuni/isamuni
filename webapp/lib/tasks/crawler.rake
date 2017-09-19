namespace :crawl do

    desc 'Crawl fb sources'
    task :fb, [:posts_per_source] => :environment do |_t, args|
        Rails.logger = Logger.new(STDOUT)
        cj = CrawlerJob.new()
        cj.perform(args[:posts_per_source].to_i)
    end
end