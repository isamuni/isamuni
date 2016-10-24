class EventsController < ApplicationController

  def index
    @future = Event.future.page(params[:future_page]).order('starts_at ASC')
    @old = Event.page(params[:old_page]).order('starts_at DESC')

    if params[:start] and params[:end]
      start_time = Time.at(params[:start].to_i / 1000.0)
      end_time = Time.at(params[:end].to_i / 1000.0)
      
      @old = @old.where(starts_at: start_time..end_time)
    else
      @old = @old.past
    end

    @old = @old.name_like(params[:query]) if params[:query]

    respond_to do |format|
        format.html { render :index }
        format.json { render json: @future | @old }
    end
  end

  def typeahead
    render json: Event.name_like(params[:query])
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
    
    # warning, date() in sqlite returns a string, but in postgres it returns a Date
    events = Event.group("date(starts_at)")
                  .order('date(starts_at) DESC')
                  .distinct.count(:uid)
    
    events = events.map do |date, count|      
      {c:[
        {v: to_js_date(date)},
        {v: count}
      ]}
    end

    datatable = {
      "cols": [
        {'id': '', 'label': 'day', 'type': 'date'},
        {'id': '', 'label': 'events', 'type': 'number'}
      ],
      "rows": events
    }

    respond_to do |format|
      format.json { render json: datatable }
    end
  end

  # def range_events
  #   start_time = Time.at(params[:start].to_i / 1000.0)
  #   end_time = Time.at(params[:end].to_i / 1000.0)

  #   events = Event.where(starts_at: start_time..end_time)
  #                .order('starts_at desc')

  #   render partial: "table", :events => @events
  # end

  def map_events events, is_today
    events = events.map{ |event| {:uid => event.uid,
                                  :name => event.name,
                                  :coordinates => event.coordinates,
                                  :isToday => is_today } }
    return events
  end

end
