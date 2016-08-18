class EventsController < ApplicationController

  def index
    three_weeks = Time.now + (3*7*24*60*60) 

    if params[:query]
      @future = Event.page(params[:future_page])
                .where("name LIKE ? and starts_at >= ?", "%#{params[:query]}%", three_weeks)
                .order('starts_at desc')
      @upcoming = Event.page(params[:upcoming_page])
                .where("name LIKE ? and starts_at >= ? and starts_at < ?", "%#{params[:query]}%", Time.zone.now.beginning_of_day, three_weeks)
                .order('starts_at desc')
      @old = Event.page(params[:old_page])
                .where("name LIKE ? and starts_at < ?", "%#{params[:query]}%", Time.zone.now.beginning_of_day)
                .order('starts_at desc')
    else
      @future = Event.page(params[:future_page])
                .where("starts_at >= ?", three_weeks)
                .order('starts_at desc')
      @upcoming = Event.page(params[:upcoming_page])
                .where(:starts_at => Time.zone.now.beginning_of_day..three_weeks)
                .order('starts_at desc')
      @old = Event.page(params[:old_page])
                .where("starts_at < ?", Time.zone.now.beginning_of_day)
                .order('starts_at desc')
    end

    respond_to do |format|
        events = {upcoming: @upcoming, future: @future, old: @old}
        format.html { render :index }
        format.json { render json: @upcoming | @future | @old }
    end
  end

  def typeahead
    @search  = Event.where("name LIKE ?", "%#{params[:query]}%")
    render json: @search
  end

  def locations
    today_events = Event.where('DATE(starts_at) = ? AND coordinates IS NOT NULL', Date.today)
    future_events = Event.where('starts_at > ? AND coordinates IS NOT NULL', (Date.today + 1))
    
    today_events = map_events(today_events, true)
    future_events = map_events(future_events, false)

    all_events = today_events + future_events
    render json: all_events
  end

  def all_locations
    events = Event.select("date(starts_at) as starts_at")
                  .group("date(starts_at)")
                  .order('starts_at desc')
                  .distinct.count(:uid)
    
    events = events.map { |event| {:c => [
      {:v =>
        'Date('
        .concat(
          event[0][0..3] # year
          .concat(', ')
          .concat((event[0][5..6].to_i - 1).to_s) # month (0-based)
          .concat(', ')
          .concat(event[0][8..9])
          )
        .concat(')')},
      {:v => event[1]}
      ]} }

    datatable = {
      "cols":
        [{'id': '', 'label': 'day', 'type': 'date'},
        {'id': '', 'label': 'events', 'type': 'number'}],
      "rows":
      events
    }

    respond_to do |format|
      format.json { render json: datatable }
    end
  end

  def range_events
    start_time = Time.at(params[:start].to_i / 1000.0)
    end_time = Time.at(params[:end].to_i / 1000.0)

    @events = Post.where(:starts_at => start_time..end_time)
                 .order('starts_at desc')

    # TODO - return the events to the index page
    # render partial: "events", :events => @events
  end

  def map_events events, is_today
    events = events.map{ |event| {:uid => event.uid,
                                  :name => event.name,
                                  :coordinates => event.coordinates,
                                  :isToday => is_today } }
    return events
  end

end
