class CreateCrawlerSources < ActiveRecord::Migration[5.0]
 
  def change
    create_table :crawler_sources do |t|
      t.string :uid
      t.string :stype
      t.string :source
      t.string :name
      t.string :privacy
      t.string :icon_link
      
      t.timestamps
    end
  end
end
