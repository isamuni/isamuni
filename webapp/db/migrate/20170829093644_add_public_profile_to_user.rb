class AddPublicProfileToUser < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.boolean :public_profile, default: true
    end
  end
end
