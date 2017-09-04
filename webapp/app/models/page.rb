# frozen_string_literal: true
class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :owners, class_name: 'User', join_table: :owners_pages
  has_paper_trail

  enum kind: [:company, :community]

  validates :name, presence: true, uniqueness: true


  def self.companies
    where(kind: Page.kinds[:company])
  end

  def self.communities
    where(kind: Page.kinds[:community])
  end

  def fb_id
    /www.facebook.com\/([\w\.\-\_]+)\/?$/.match(fbpage)&.[](1)
  end

  def pic(height = 100)
    if fb_id
      "https://graph.facebook.com/#{fb_id}/picture?height=#{height}"
    elsif twitter_id
      if height >= 100
        twitter_url + "/profile_image?size=original"
      else
        twitter_url + "/profile_image"
      end
    end
  end

  def fb_url
    "https://www.facebook.com/#{fb_id}/" if fb_id
  end

  def twitter_id
    return nil if twitterpage.blank?
    if twitterpage.include? '@'
      twitterpage.split('@')[1]
    else
      twitterpage
    end
  end

  def twitter_url
    "https://twitter.com/#{twitter_id}" if twitter_id
  end

  def as_json(options = {})
    if options
      super(options)
    else
      super(only: [:name, :description, :contacts, :links, :slug, :website])
    end
  end


end
