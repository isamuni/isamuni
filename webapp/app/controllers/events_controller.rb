class EventsController < ApplicationController

  def index
    three_weeks = Time.now + (3*7*24*60*60) 

    if params[:query]
      @future = Event.page(params[:page])
                .where("name LIKE ? and starts_at >= ?", "%#{params[:query]}%", three_weeks)
                .order('starts_at desc')
      @upcoming = Event.page(params[:page])
                .where("name LIKE ? and starts_at >= ? and starts_at < ?", "%#{params[:query]}%", Time.zone.now.beginning_of_day, three_weeks)
                .order('starts_at desc')
      @old = Event.page(params[:page])
                .where("name LIKE ? and starts_at < ?", "%#{params[:query]}%", Time.zone.now.beginning_of_day)
                .order('starts_at desc')
    else
      @future = Event.page(params[:page])
                .where("starts_at >= ?", three_weeks)
                .order('starts_at desc')
      @upcoming = Event.page(params[:page])
                .where(:starts_at => Time.zone.now.beginning_of_day..three_weeks)
                .order('starts_at desc')
      @old = Event.page(params[:page])
                .where("starts_at < ?", Time.zone.now.beginning_of_day)
                .order('starts_at desc')
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

  def locations
    today_events = Event.where('starts_at = ? AND coordinates IS NOT NULL', Time.zone.now.beginning_of_day)
    future_events = Event.where('starts_at > ? AND coordinates IS NOT NULL', Time.zone.now.beginning_of_day)
    
    today_events = map_events(today_events, true)
    future_events = map_events(future_events, false)

    all_events = today_events + future_events
    render json: all_events
  end

  def map_events events, is_today
    events = events.map{ |event| {:uid => event.uid,
                                  :name => event.name,
                                  :coordinates => event.coordinates,
                                  :isToday => is_today } }
    return events
  end

end
