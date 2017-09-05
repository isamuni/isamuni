# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  WillPaginate.per_page = 10

  before_action :set_paper_trail_whodunnit

  protected

  def current_user
    return @current_user if @current_user

    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      if @current_user
        return @current_user
      else
        session[:user_id] = nil
        return nil
      end
    end
  end

  def check_logged_in
    redirect_to login_path, notice: 'You need to be logged in to perform that action' unless current_user
  end

  helper_method :current_user

  def page_url(page, _options = {})
    if page.community?
      community_url page
    else
      company_url page
    end
  end

  def page_path(page, _options = {})
    if page.community?
      community_path page
    else
      company_path page
    end
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end

  # Call this function to stop users from accessing admins functionalities and/or
  # pages that have been blocked
  def require_admin
    unless !current_user.nil? && current_user.admin?
      render file: 'public/401.html', status: :unauthorized
    end
  end

  def to_js_date(date)
    d = date.is_a?(String) ? Date.parse(date) : date
    "Date(#{d.year},#{d.month - 1},#{d.day})"
  end

  def paginated_json(page)
    {
      current_page: page.current_page,
      per_page: page.per_page,
      total_entries: page.total_entries,
      entries: page
    }
  end

  helper_method :page_url
  helper_method :page_path

  # Simple CSP implementation. Alternatively use secure_headers gem
  # before_action :set_csp
  #
  # def set_csp
  #   response.headers['Content-Security-Policy'] = "default-src 'self'; style-src 'self' 'unsafe-inline'"
  # end

end
