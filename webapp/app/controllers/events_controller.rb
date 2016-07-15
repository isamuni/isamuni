class EventsController < ApplicationController

  def index
	  three_weeks = Time.now + (3*7*24*60*60) 
    @future = Event.where("starts_at >= ?", three_weeks).limit(100).order('starts_at desc')
    @upcoming = Event.where(:starts_at => Time.zone.now.beginning_of_day..three_weeks).limit(100).order('starts_at desc')
    @old = Event.where("starts_at < ?", Time.zone.now.beginning_of_day).limit(78).order('starts_at desc')

    puts "SIMONE"
    puts @old[-1].uid
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

end
