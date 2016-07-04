class EventsController < ApplicationController

def index
    @events = Event.limit(100).order('created_at asc')
  end

end