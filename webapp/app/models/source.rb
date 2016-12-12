# frozen_string_literal: true
class Source < ApplicationRecord
  has_many :posts
  has_many :events

  def isOPEN
    privacy.eql? 'OPEN'
  end
end
