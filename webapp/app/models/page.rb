class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :user, foreign_key: "owner_id"

  enum kind: [ :company, :community ]
  validates :name, presence: true
end
