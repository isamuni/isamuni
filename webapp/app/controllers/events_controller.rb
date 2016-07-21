class EventsController < ApplicationController

  def index
    three_weeks = Time.now + (3*7*24*60*60) 

    if params[:query]
      @future = Event.where("name LIKE ? and starts_at >= ?", "%#{params[:query]}%", three_weeks).limit(100).order('starts_at desc')
      @upcoming = Event.where("name LIKE ? and starts_at >= ? and starts_at < ?", "%#{params[:query]}%", Time.zone.now.beginning_of_day, three_weeks).limit(100).order('starts_at desc')
      @old = Event.where("name LIKE ? and starts_at < ?", "%#{params[:query]}%", Time.zone.now.beginning_of_day).limit(78).order('starts_at desc')
    else
      @future = Event.where("starts_at >= ?", three_weeks).limit(100).order('starts_at desc')
      @upcoming = Event.where(:starts_at => Time.zone.now.beginning_of_day..three_weeks).limit(100).order('starts_at desc')
      @old = Event.where("starts_at < ?", Time.zone.now.beginning_of_day).limit(78).order('starts_at desc')
    end

    respond_to do |format|
        events = {'upcoming' => @upcoming, 'future' => @future, 'old' => @old}
        format.html { render :index }
        format.json { render json: events }
    end
  end

  def typeahead
    @search  = Event.where("name LIKE ?", "%#{params[:query]}%")
    render json: @search
  end

  # How to get coordinates given address
  # http://nominatim.openstreetmap.org/search?format=json&q=50+watson+avenue+st+andrews
  def locations
    events = Event.where('coordinates IS NOT NULL')
    events = events.map{ |event| {:coordinates => event.coordinates} }

    render json: events
  end

end
