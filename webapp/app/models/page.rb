class Page < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner_id"
end
