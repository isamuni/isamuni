class RenamePageUrlToWebsite < ActiveRecord::Migration[5.1]
  def change
    rename_column :pages, :url, :website    
  end
end
