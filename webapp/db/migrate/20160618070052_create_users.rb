class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name, null:false
      t.string :oauth_token
      t.string :occupation
      
      t.datetime :oauth_expires_at
      t.text :description
      t.text :projects
      t.text :links

      t.timestamps null: false

      t.string :slug, null:false

    end

    add_index :users, :slug, :unique => true

  end
end
