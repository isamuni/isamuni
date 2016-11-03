class AddGroupOriginToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :fb_group, :string

    Post.find_each do |post|
    	post.fb_group = post.uid.split('_')[0]
    	post.save!
    end
  end
end
