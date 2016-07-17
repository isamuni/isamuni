class AdminController < ApplicationController

  def index
  	admins = ENV['ISAMUNI_ADMINS']

  	if current_user != nil && admins.include?(current_user.uid)
  		@pages = Page.where('active = ?', false)
	else
		@pages =[] 
	end
  end


end
