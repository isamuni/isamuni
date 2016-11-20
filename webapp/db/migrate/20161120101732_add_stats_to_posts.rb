class AddStatsToPosts < ActiveRecord::Migration[5.0]

  def change
    add_column :posts, :likes_count, :integer
    add_column :posts, :shares_count, :integer
    add_column :posts, :comments_count, :integer
  end
end
