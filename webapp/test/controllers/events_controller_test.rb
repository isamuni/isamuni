# frozen_string_literal: true
require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get index in json' do
    get :index, format: :json
    assert_response :success
  end

  test 'should get index in ical' do
    get :index, format: :ical
    assert_response :success
    assert response.header['Content-Type'].include? "text/calendar"
  end
end
