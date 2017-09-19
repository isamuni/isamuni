class AddLastCrawledToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :last_crawled_at, :datetime
  end
end
