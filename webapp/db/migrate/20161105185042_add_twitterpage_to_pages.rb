class AddTwitterpageToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :twitterpage, :string
  end
end
