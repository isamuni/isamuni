require_relative "sanitize"

class Event < ApplicationRecord

  scope :future, -> { where "starts_at >= ?", Time.zone.now.beginning_of_day }
  scope :past, -> { where "starts_at < ?", Time.zone.now.beginning_of_day }
  scope :only_with_coordinates, -> { where "coordinates IS NOT NULL" }

  def self.name_like query
    where "name LIKE ?", "%#{query}%"
  end

  def self.from_fb_event fb_event

    #handle optional content
    content = if fb_event['description'] then Sanitize.encode(fb_event['description']) else nil end

    event = Event.new({
      uid: fb_event['id'],
      name: Sanitize.encode(fb_event['name']),
      content: content,
      starts_at: fb_event['start_time'],
      ends_at: fb_event['end_time']
    })
    event.location_name = fb_event['place'] ? Sanitize.encode(fb_event['place']['name']) : nil
    event.location = fb_event['place'] ? Sanitize.encode(fb_event['place']['location'].to_json) : nil

    if fb_event['place'] && fb_event['place']['location']
      event.coordinates = fb_event['place']['location']['latitude'].to_s + ', ' + fb_event['place']['location']['longitude'].to_s
    end

    if fb_event['parent_group']
      event.organiser = fb_event['parent_group']['name']
    else
      event.organiser = fb_event['owner']['name']
    end

    event
  end

  def as_json(options={})
    super(only: [:name, :starts_at, :content, :location, :location_name])
  end

end
