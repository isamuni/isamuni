class AddLocationFieldsToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :city, :string
    add_column :pages, :province, :string
    add_column :pages, :region, :string
    add_column :events, :province, :string
  end
end
