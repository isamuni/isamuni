class Event < ActiveRecord::Base

  def self.from_fb_event fb_event
    event = Event.new({
      uid: fb_event['id'],
      name: fb_event['name'],
      content: fb_event['description'],
      category: fb_event['category'],
      starts_at: fb_event['start_time'],
      ends_at: fb_event['end_time']
    })
    event.location_name = fb_event['place'] ? fb_event['place']['name'] : nil
    event.location = fb_event['place'] ? fb_event['place']['location'] : nil
    event
  end

end
