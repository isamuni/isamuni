class Source < ApplicationRecord
  has_many :posts
  has_many :events

  def self.from_fb_source fb_group
    group_uid = fb_group['id']
    group_name = fb_group['name']
    group_privacy = fb_group['privacy']
    group_icon = fb_group['icon']

    if exists?(uid: group_uid)
		group = where(uid: group_uid).first
		group.touch
    else
		group = Source.new()

	    group.stype = 'group'
	    group.source = 'fb'
    end

    group.uid = group_uid
    group.name = group_name
    group.privacy = group_privacy
    group.icon_link = group_icon

    group
  end

end
