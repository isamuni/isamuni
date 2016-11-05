class AddTwitterPageToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :twitter_page, :string
  end
end
