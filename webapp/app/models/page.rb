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

  def page_pic
    # Very naive method to get FB page-name/id
    unless fbpage.nil?
      id = fbpage.split("facebook.com/")[1].split("/")[0]
      'http://graph.facebook.com/' + id + '/picture'
    else
      ''
    end
  end

  def as_json(options={})
    super(only: [:id, :name])
  end

  enum kind: [ :company, :community ]
  validates :name, presence: true
end
