class HomeController < ApplicationController

  def index
    @posts_count = Post.where('created_at >= ?', 1.week.ago).count
    @users_count = User.count
    @communities_count = Page.communities.where('active = ?', true).count
    @companies_count = Page.companies.where('active = ?', true).count

    three_weeks = Time.now + (3*7*24*60*60) 
    @upcoming_events_count = Event.where(:ends_at => Time.zone.now.beginning_of_day..three_weeks)
                            .order('ends_at desc')
                            .count
  end

end
