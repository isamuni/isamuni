class MigrateTags < ActiveRecord::Migration[5.0]
  def up
    if ActiveRecord::Base.connection.column_exists? 'users', 'tags'
      User.all.each do |u|
        tags = u.tags
        
        if tags and not tags.include? ',' #normalize space-separated tag list
          tags = tags.split(/\W+/).join(", ")
        end
        
        u.skill_list = tags
        u.save
      end
    end
  end
end
