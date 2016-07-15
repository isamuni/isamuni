require_relative "sanitize"

class Event < ApplicationRecord

  def self.from_fb_event fb_event
    event = Event.new({
      uid: fb_event['id'],
      name: Sanitize.encode(fb_event['name']),
      content: Sanitize.encode(fb_event['description']),
      starts_at: fb_event['start_time'],
      ends_at: fb_event['end_time']
    })
    event.location_name = fb_event['place'] ? Sanitize.encode(fb_event['place']['name']) : nil
    event.location = fb_event['place'] ? Sanitize.encode(fb_event['place']['location'].to_json) : nil
    event
  end

end
