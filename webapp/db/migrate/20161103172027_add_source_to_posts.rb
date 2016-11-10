class AddSourceToPosts < ActiveRecord::Migration[5.0]

  def change
    add_column :posts, :source_id, :integer
    add_index :posts, :source_id

    add_column :events, :source_id, :integer
    add_index :events, :source_id
  end

end
