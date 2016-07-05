class EventsController < ApplicationController

def index
    #@future = Event.where().limit(100).order('starts_at desc')
    @upcoming = Event.where().limit(100).order('starts_at desc')
    @old = Event.where("starts_at < ?", Time.zone.now.beginning_of_day).limit(100).order('starts_at desc')
  end

end