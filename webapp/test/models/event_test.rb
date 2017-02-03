# frozen_string_literal: true
require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'multiple days current event ' do
    e = events(:one)
    e.starts_at = 1.day.ago
    e.ends_at = 1.day.from_now
    e.save!

    assert e.current?
  end

  test 'future event without ends_at' do
    e = events(:one)
    e.id = 12345
    e.starts_at = 2.days.from_now
    e.ends_at = nil
    e.save!

    assert Event.future.pluck(:id).include? 12345
  end

  test 'current? for events with nil ends_at' do
    e = events(:'current-nil-ends_at')
    e.id = 12345
    e.starts_at = Time.zone.now.beginning_of_day
    e.ends_at = nil
    e.save!

    assert e.current?
  end

end
