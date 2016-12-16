class AddUrlToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :url, :string
  end
end
