class CreateWikipages < ActiveRecord::Migration[5.1]
  def change
    create_table :wikipages do |t|
      t.string :name
      t.string :slug
      t.text :content

      t.timestamps
    end

    add_index :wikipages, :slug, :unique => true    
  end
end
