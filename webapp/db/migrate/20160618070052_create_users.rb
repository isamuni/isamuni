class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name, null:false

      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.string :occupation

      t.text :description
      t.text :projects
      t.text :links
      t.text :tags

      t.timestamps null: false

      t.string :slug, null:false

      t.boolean :banned, default: false 

    end

    add_index :users, :slug, :unique => true

  end
end
