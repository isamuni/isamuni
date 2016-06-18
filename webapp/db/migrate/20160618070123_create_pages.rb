class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.integer :owner_id
      t.boolean :active
      t.string :name
      t.string :links
      t.string :description
      t.string :contacts
      t.string :coordinates

      t.timestamps null: false
    end
  end
end
