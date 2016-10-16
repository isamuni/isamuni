class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, null:false
      t.integer :kind, null:false
      t.integer :owner_id, null:false
      t.boolean :active

      t.string :sector
      t.string :no_employees
      t.string :links
      t.string :description
      t.string :contacts
      t.string :coordinates
      t.string :location
      t.string :lookingfor
      t.string :fbpage

      t.timestamps null: false
      t.string :slug, null: false

    end
    add_index :pages, :slug, :unique => true

  end
end
