# frozen_string_literal: true
class Source < ApplicationRecord
  has_many :posts
  has_many :events

  enum status: {disabled: 0, working: 1, failing: 2}

  def from_fb_group(fb_group)
    @stype = 'group'
    @source = 'fb'
    @name = fb_group['name']
    @privacy = fb_group['privacy']
    @icon_link = fb_group['icon']
    
    if @privacy != 'OPEN'
      @status = 'disabled'
    end

    self
  end

  def self.from_fb_group(fb_group)
    group = find_or_initialize_by(uid: fb_group['id'])
    group.from_fb_group(fb_group)
  end

  def from_fb_page(fb_page)
    @stype = 'page'
    @source = 'fb'
    @name = fb_page['name']
    @privacy = 'OPEN'
    self
  end

  def self.from_fb_page(fb_page)
    page = find_or_initialize_by(uid: fb_page['id'])
    page.from_fb_page(fb_page)
  end

end
