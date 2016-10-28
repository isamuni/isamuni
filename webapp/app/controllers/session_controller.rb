class SessionController < ApplicationController
  layout "user_area"

  def login
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])

    if Alloweduser.exists?(user_uid: user.uid) && Alloweduser.where(updated_at: 1.days.ago..DateTime.now)
      session[:user_id] = user.id
      redirect_to edit_user_url
    else
      redirect_to root_url, alert: "Not allowed to login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out succesfully"
  end

  def auth_failure
    redirect_to root_url, alert: "Authentication failure"
  end
end
