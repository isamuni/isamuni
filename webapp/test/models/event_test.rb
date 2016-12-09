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
end
