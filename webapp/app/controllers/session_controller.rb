class SessionController < ApplicationController
  layout "user_area"

  def login
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to edit_user_url
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out succesfully"
  end

  def auth_failure
    redirect_to root_url, alert: "Authentication failure"
  end
end
