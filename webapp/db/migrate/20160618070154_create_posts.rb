class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :author_name
      t.string :author_uid
      t.string :link
      t.text :content

      t.timestamps null: false
    end
  end
end
