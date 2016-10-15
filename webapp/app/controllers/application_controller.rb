class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  WillPaginate.per_page = 10

protected 

  def current_user
    if @current_user
      return @current_user
    end

    if session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
      if @current_user
        return @current_user
      else
        session[:user_id] = nil
        return nil
      end
    end
  end

  def check_logged_in
    redirect_to login_path, notice: "You need to be logged in to perform that action" unless current_user
  end

  helper_method :current_user

  def page_url(page, options = {})
    if page.community?
      community_url page
    else
      company_url page
    end
  end

  def page_path(page, options = {})
    if page.community?
      community_path page
    else
      company_path page
    end
  end

  def not_found
    render :file => "#{Rails.root}/public/404.html",  :status => 404
  end

  # Call this function to stop users from accessing admins functionalities and/or
  # pages that have been blocked
  def require_admin
    unless current_user != nil && current_user.is_admin?
      render :file => "public/401.html", :status => :unauthorized
    end
  end

  helper_method :page_url
  helper_method :page_path

end
