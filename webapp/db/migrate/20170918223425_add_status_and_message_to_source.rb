class AddStatusAndMessageToSource < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :status, :integer
    add_column :sources, :message, :text
  end
end
