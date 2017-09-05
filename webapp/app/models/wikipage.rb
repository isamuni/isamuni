class Wikipage < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    has_paper_trail
    
    validates :name, presence: true, uniqueness: true
    validates :content, presence: true

    def should_generate_new_friendly_id?
        slug.blank?
    end
end