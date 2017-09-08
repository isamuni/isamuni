# frozen_string_literal: true
class SessionController < ApplicationController
  layout 'user_area'

  def login
  end

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    
    user_is_new = user.id.nil?
    user.save

    if user_is_new
      NotificationMailer.new_user_notification(user).deliver_later
    end

    session[:user_id] = user.id
    redirect_to me_edit_user_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out succesfully'
  end

  def auth_failure
    redirect_to root_url, alert: 'Authentication failure'
  end
end
