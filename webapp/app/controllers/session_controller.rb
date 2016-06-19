class SessionController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_uid] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_uid] = nil
    redirect_to root_url
  end

  def auth_failure
    redirect_to root_url
  end
end
