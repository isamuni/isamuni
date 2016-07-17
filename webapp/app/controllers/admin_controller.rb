class AdminController < ApplicationController

  def index
  	admins = ENV['ISAMUNI_ADMINS']

  	if current_user != nil && admins.include?(current_user.uid)
  		@pages = Page.all
	else
		@pages =[] 
	end
  end

  def page_state
  	page = Page.where('id = ?', params[:post_id]).first
  	if page.active == false
  		page.active = true
  	else
  		page.active = false
  	end
  	
  	page.save
  end

end
