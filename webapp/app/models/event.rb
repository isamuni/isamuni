require_relative "sanitize"

class Event < ApplicationRecord

  scope :future, -> { where "ends_at >= ?", Time.zone.now.beginning_of_day }
  scope :past, -> { where "ends_at < ?", Time.zone.now.beginning_of_day }
  scope :only_with_coordinates, -> { where "coordinates IS NOT NULL" }

  def self.name_like query
    ilike :name, query
  end

  def self.from_fb_event fb_event

    uid = fb_event['id']
    name = Sanitize.encode(fb_event['name'])
    content = if fb_event['description'] then Sanitize.encode(fb_event['description']) else nil end
    starts_at = fb_event['start_time']
    ends_at = fb_event['end_time']

    if Event.exists?(uid: uid)
      event = Event.where(uid: uid).first
    else
      event = Event.new()
    end

    event.uid = uid
    event.name = name
    event.content = content
    event.starts_at = starts_at
    event.ends_at = ends_at

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

  def current?
    ends_at > Time.zone.now.beginning_of_day and starts_at < Time.zone.now.end_of_day
  end

  def external_link
    'https://www.facebook.com/events/' + uid
  end

  def coord
    if coordinates
      coordinates.gsub(/\s+/, "")
    else
      nil
    end
  end


  def as_json(options={})
    super(only: [:name, :starts_at, :ends_at, :content, :location, :location_name, :coordinates])
  end

end
