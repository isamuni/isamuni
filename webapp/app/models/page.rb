# frozen_string_literal: true
class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :owners, class_name: 'User', join_table: :owners_pages
  has_paper_trail

  def self.companies
    where(kind: Page.kinds[:company])
  end

  def self.communities
    where(kind: Page.kinds[:community])
  end

  def fb_id
    /www.facebook.com\/(\w+)/.match(fbpage)&.[](1)
  end

  def pic(height = 100)
    "http://graph.facebook.com/#{fb_id}/picture?height=#{height}" if fb_id
  end

  def fb_url
    "https://www.facebook.com/#{fb_id}/" if fb_id
  end

  def twitter_url
    if twitterpage
      page = twitterpage.split('@')[1]
      "https://twitter.com/#{page}"
    end
  end

  def as_json(options = {})
    if options
      super(options)
    else
      super(only: [:name, :description, :contacts, :links, :slug, :url])
    end
  end

  enum kind: [:company, :community]
  validates :name, presence: true
end
