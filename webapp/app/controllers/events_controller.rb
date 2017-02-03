# frozen_string_literal: true
class EventsController < ApplicationController
  def index
    @future = Event.future.page(params[:future_page]).order_asc
    @old = Event.page(params[:old_page]).order_desc

    if params[:start] && params[:end]
      @start_time = Time.at(params[:start].to_i / 1000.0)
      @end_time = Time.at(params[:end].to_i / 1000.0)

      @old = @old.where(ends_at: @start_time..@end_time)
    else
      @old = @old.past
    end

    @old = @old.name_like(params[:query]) if params[:query]

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @future | @old }
      format.ical {
        calendar = Icalendar::Calendar.new
        @future.each do |event|
          calendar.add_event(event.to_ics)
        end
        calendar.publish
        render :body => calendar.to_ical
      }
    end
  end

  def typeahead
    render json: Event.name_like(params[:query])
  end

  def locations
    today_events = Event.future.where('coordinates IS NOT NULL')

    event_data = today_events.map do |event|
      { uid: event.uid,
        name: event.name,
        coordinates: event.coordinates,
        isToday: event.current? }
    end

    render json: event_data
  end

  def sources
    counts = Event.group(:source_id).count

    sources = Source.find(counts.keys).map do |e|
      e.as_json.merge(count: counts[e.id])
    end

    render json: sources
  end

  def all_events
    events = Event.where('date(ends_at) < ?', Date.today)
                  .group('date(ends_at)')
                  .order('date(ends_at) DESC')
                  .distinct.count(:uid)

    events = events.map do |date, count|
      { c: [
        { v: to_js_date(date) },
        { v: count }
      ] }
    end

    datatable = {
      "cols": [
        { 'id': '', 'label': 'day', 'type': 'date' },
        { 'id': '', 'label': 'events', 'type': 'number' }
      ],
      "rows": events
    }

    respond_to do |format|
      format.json { render json: datatable }
    end
  end
end
