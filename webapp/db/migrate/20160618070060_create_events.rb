class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :uid
      t.string :name
      t.text :content
      t.string :category
      
      t.timestamps null: false

      t.datetime :starts_at
      t.datetime :ends_at

      t.string :location_name
      t.string :location
      t.string :coordinates
      
    end
  end
end
