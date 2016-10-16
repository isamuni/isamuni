class SessionController < ApplicationController
  layout "user_area"

  def login
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])

    if Alloweduser.exists?(user_uid: user.uid) && Alloweduser.where(updated_at: 1.days.ago..DateTime.now)
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def auth_failure
    redirect_to root_url
  end
end
