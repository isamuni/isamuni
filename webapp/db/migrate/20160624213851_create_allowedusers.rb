class CreateAllowedusers < ActiveRecord::Migration
  def change
    create_table :allowedusers do |t|
      t.string :group_uid
      t.string :user_uid
      t.datetime :updated_at,    null: false
    end
  end
end
