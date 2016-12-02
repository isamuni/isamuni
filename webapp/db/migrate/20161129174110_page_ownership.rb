class PageOwnership < ActiveRecord::Migration[5.0]
  def change
    create_table :owners_pages, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :page, index: true
    end

    create_table :ownership_requests do |t|
      t.belongs_to :user, index: true
      t.belongs_to :page, index: true
      t.string :message
    end
  end
end
