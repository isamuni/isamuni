class User < ApplicationRecord
  has_many :pages, foreign_key: "owner_id"

  extend FriendlyId
  friendly_id :name, :use => :slugged

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)

      user.save!
    end
  end

  def self.safe_fields
    select(:id, :name, :uid, :slug, :occupation)
  end
  
  def first_name
    name.partition(" ").first
  end

  def profile_pic
    'http://graph.facebook.com/' + uid + '/picture'
  end
  
  def as_json(options={})
    super(only: [:name, :occupation, :projects, :description, :links])
  end

end
