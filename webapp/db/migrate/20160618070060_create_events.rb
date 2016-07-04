class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :uid
      t.string :name
      t.text :content
      
      t.timestamps null: false

      t.string :location
      t.string :coordinates
      
    end
  end
end
