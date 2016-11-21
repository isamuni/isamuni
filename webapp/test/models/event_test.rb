require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "multiple days current event " do
    e = events(:one)
    e.starts_at = 1.days.ago
    e.ends_at = 1.days.from_now
    e.save!

    assert e.current?
  end
end
