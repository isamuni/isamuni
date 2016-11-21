class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :user, foreign_key: "owner_id"

  def self.companies
    where(kind: Page::kinds[:company])
  end

  def self.communities
    where(kind: Page::kinds[:community])
  end

  def fb_id
    /www.facebook.com\/(\w+)/.match(fbpage)&.[](1)
  end

  def pic height=100
    if fb_id
      "http://graph.facebook.com/#{fb_id}/picture?height=#{height}"
    else
      nil
    end
  end

  def fb_url
    if fb_id
      "https://www.facebook.com/#{fb_id}/"
    else
      nil
    end
  end

  def twitter_url
    if twitterpage
      page = twitterpage.split("@")[1]
      "https://twitter.com/#{page}"
    else
      nil
    end
  end

  def as_json(options={})
    super(only: [:name, :description, :contacts, :links, :slug])
  end

  enum kind: [ :company, :community ]
  validates :name, presence: true
end
