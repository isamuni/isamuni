class User < ApplicationRecord
  acts_as_taggable_on :skills
  has_and_belongs_to_many :pages, join_table: :owners_pages
  validate :valid_skill_list

  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |user|
      user.public_profile = false
    end
    
    #update name and oauth token
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.zone.at(auth.credentials.expires_at)
    
    user
  end

  def self.searchable_columns
    [:name, :skill_list, :occupation, :description, :projects]
  end

  def first_name
    name.partition(' ').first
  end

  def profile_pic(height = '')
    height = '?height=' + height.to_s unless height == ''
    'https://graph.facebook.com/' + uid + '/picture' + height
  end

  def thumbnail
    profile_pic 50
  end

  def as_json(_options = {})
    super(only: [:name, :slug, :occupation, :projects, :description, :links],
          methods: [:thumbnail])
  end

  def is_admin?
    admins = Rails.configuration.admins
    !uid.nil? && admins.include?(uid)
  end

  private

  def valid_skill_list
    return if skill_list.nil? || skill_list.all? { |tag| tag.length < 24 }
    errors.add(:skill_list, 'includes some tag longer than 24 chars')
  end
end
