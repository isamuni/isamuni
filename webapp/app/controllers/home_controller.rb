# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @posts_count = Post.where('created_at >= ?', 1.week.ago).count
    @users_count = User.count
    @communities_count = Page.communities.where('active = ?', true).count
    @companies_count = Page.companies.where('active = ?', true).count

    today = Time.zone.now.beginning_of_day
    @upcoming_events_count = Event.where('ends_at >= ? OR starts_at >= ?', today, today)
                                  .order('ends_at desc')
                                  .count
  end
end
