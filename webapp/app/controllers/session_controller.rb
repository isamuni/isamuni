class SessionController < ApplicationController
  layout "user_area"

  def login
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])

    # TODO - check if user is in the PAC group (see issue #15 on github)

    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def auth_failure
    redirect_to root_url
  end
end
