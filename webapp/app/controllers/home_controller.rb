class HomeController < ApplicationController

  MAX_NUMBER_OF_POSTS = 50
  MAX_NUMBER_OF_JOB_POSTS = 20

  def index
    @posts_count = Post.where('created_at >= ?', 1.week.ago).count
    @users_count = User.count
    @communities_count = Page.communities.where('active = ?', true).count
    @companies_count = Page.companies.where('active = ?', true).count

    three_weeks = Time.now + (3*7*24*60*60) 
    @upcoming_events_count = Event.where(:starts_at => Time.zone.now.beginning_of_day..three_weeks).limit(100).order('starts_at desc').count
  end

end
