# frozen_string_literal: true
require_relative 'sanitize'

class Event < ApplicationRecord
  belongs_to :source, optional: true

  scope :future, -> { where 'ends_at >= ?', Time.zone.now.beginning_of_day }
  scope :past, -> { where 'ends_at < ?', Time.zone.now.beginning_of_day }
  scope :only_with_coordinates, -> { where 'coordinates IS NOT NULL' }

  def self.name_like(query)
    ilike :name, query
  end

  def current?
    ends_at > Time.zone.now.beginning_of_day && starts_at < Time.zone.now.end_of_day
  end

  def external_link
    'https://www.facebook.com/events/' + uid
  end

  def coord
    return nil unless coordinates
    coordinates.gsub(/\s+/, '')
  end

  def as_json(_options = {})
    super(only: [:name, :starts_at, :ends_at, :content, :location, :location_name, :coordinates],
          methods: [:external_link])
  end
end
