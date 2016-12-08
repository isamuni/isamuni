# frozen_string_literal: true
class Source < ApplicationRecord
  has_many :posts
  has_many :events

  def self.from_fb_group(fb_group)
    group = find_or_initialize_by(uid: fb_group['id'])

    group.stype = 'group'
    group.source = 'fb'
    group.name = fb_group['name']
    group.privacy = fb_group['privacy']
    group.icon_link = fb_group['icon']

    group
  end

  def self.from_fb_page(fb_page)
    page = find_or_initialize_by(uid: fb_page['id'])

    page.stype = 'page'
    page.source = 'fb'
    page.name = fb_page['name']

    page
  end

  def isOPEN
    privacy.eql? 'OPEN'
  end
end
