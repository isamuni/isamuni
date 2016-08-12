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

  def as_json(options={})
    super(only: [:id, :name])
  end

  enum kind: [ :company, :community ]
  validates :name, presence: true
end
