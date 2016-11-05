class CrawlerSource < ApplicationRecord

  def self.from_fb_source fb_group
    group_uid = fb_group['id']
    group_name = fb_group['name']
    group_privacy = fb_group['privacy']
    group_icon = fb_group['icon']

    if CrawlerSource.exists?(uid: group_uid)
		group = CrawlerSource.where(uid: group_uid).first
		group.name = group_name
		group.privacy = group_privacy
		group.icon_link = group_icon
		group.touch
    else
		group = CrawlerSource.new()
	    group.uid = group_uid
	    group.name = group_name
	    group.privacy = group_privacy
	    group.icon_link = group_icon

	    group.stype = 'group'
	    group.source = 'fb'
    end

    group
  end

end
