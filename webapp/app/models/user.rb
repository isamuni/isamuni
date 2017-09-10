class User < ApplicationRecord
  enum role: {user: 0, editor: 1, admin: 2}
  
  has_and_belongs_to_many :pages, join_table: :owners_pages
  acts_as_taggable_on :skills
  
  validates :name, presence: true  
  validate :valid_skill_list

  with_options on: :manual_update, if: :public_profile do |p|
    p.validates :description, presence: true
    p.validates :occupation, presence: true
  end

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

  private

  def valid_skill_list
    return if skill_list.nil? || skill_list.all? { |tag| tag.length < 24 }
    errors.add(:skill_list, 'includes some tag longer than 24 chars')
  end
end
