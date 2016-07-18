class AdminController < ApplicationController
  before_action :require_admin

  def index
  		@pages = Page.all
	end

  def make_page_inactive
    page = Page.find(params[:pageid])
    page.active = false
    page.save
  end

  def make_page_active
    page = Page.find(params[:pageid])
    page.active = true
    page.save
  end

  def require_admin
    admins = ENV['ISAMUNI_ADMINS'].split(" ")
    unless current_user != nil && admins.include?(current_user.uid)
      render :file => "public/401.html", :status => :unauthorized
    end
  end

end
