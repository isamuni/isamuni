class Source < ApplicationRecord
  has_many :posts
  has_many :events

  def self.from_fb_group fb_group
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

  def self.from_fb_page fb_page
    page_uid = fb_page['id']
    page_name = fb_page['name']

    if exists?(uid: page_uid)
      page = where(uid: page_uid).first
      page.touch
    else
      page = Source.new()

      page.stype = 'page'
      page.source = 'fb'
    end

    page.uid = page_uid
    page.name = page_name

    page
  end

  def isOPEN
    privacy.eql? "OPEN"
  end

end
