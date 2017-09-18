class Me::OwnershipRequestsController < ApplicationController
  layout 'user_area'
  before_action :check_logged_in
  before_action :require_admin, only: [:index, :handle]

  def create
    p = Page.find(params[:page])

    if p.owners.include? current_user
      flash[:notice] = "Hai già la ownership per questa pagina"
    else
      request = OwnershipRequest.create!(page_id: p.id, user_id: current_user.id)
      NotificationMailer.ownership_request_notification(request).deliver_now
      flash[:notice] = "Richiesta di ownership inviata"
    end

    redirect_to '/me/pages'
  end

  def new
    @page = Page.find(params[:page])
  end

  def index
    @requests = OwnershipRequest.all
  end

  def accept
    request = OwnershipRequest.find(params[:id])
    unless request.page.owners.include? request.user
      request.page.owners << request.user
      request.page.save!
      flash[:notice] = "Accepted"
    else
      flash[:notice] = "User already owned that page"
    end
    request.delete
    redirect_to action: :index
  end

  def reject
    request = OwnershipRequest.find(params[:id])    
    request.delete
    flash[:notice] = "Rejected"
    redirect_to action: :index
  end
end
