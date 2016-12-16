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

  def self.from_fb_event(fb_event)
    event = find_or_initialize_by(uid: fb_event['id'])

    event.name = Sanitize.encode(fb_event['name'])
    event.content = Sanitize.encode(fb_event['description'])
    event.starts_at = fb_event['start_time']
    event.ends_at = fb_event['end_time']
    event.organiser = fb_event.dig('parent_group', 'name') || fb_event.dig('owner', 'name')
    event.location_name = Sanitize.encode fb_event.dig('place', 'name')

    location = fb_event.dig('place', 'location')
    if location
      event.location = Sanitize.encode(location.to_json)
      event.coordinates = "#{location['latitude']}, #{location['longitude']}"
    end

    event
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
