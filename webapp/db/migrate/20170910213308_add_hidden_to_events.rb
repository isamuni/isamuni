class AddHiddenToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :hidden, :boolean, default: false
  end
end
