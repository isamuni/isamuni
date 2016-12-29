# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :source, optional: true

  scope :future, -> {
    today = Time.zone.now.beginning_of_day
    where 'ends_at >= ? OR starts_at >= ?', today, today
  }

  scope :past, -> {
    today = Time.zone.now.beginning_of_day
    where 'ends_at < ? OR ( starts_at < ? AND ends_at IS NULL)', today, today
  }

  scope :only_with_coordinates, -> { where 'coordinates IS NOT NULL' }

  def self.order_asc
    order "COALESCE(ends_at,starts_at) ASC"
  end

  def self.order_desc
    order "COALESCE(ends_at,starts_at) DESC"
  end

  def self.name_like(query)
    ilike :name, query
  end

  def current?
    if ends_at && starts_at
      return ends_at > Time.zone.now.beginning_of_day &&
        starts_at < Time.zone.now.end_of_day
    else
      return starts_at&.today? || ends_at&.today? || false
    end

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
