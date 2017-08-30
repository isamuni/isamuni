class Me::OwnershipRequestsController < ApplicationController

  def create
    p = Page.find(params[:page])

    if p.owners.include? current_user
      render plain: 'Hai già la ownership per questa pagina', status: 404
    else
      request = OwnershipRequest.create!(page_id: p.id, user_id: current_user.id)
      NotificationMailer.ownership_request_notification(request).deliver_later
      render plain: 'Richiesta di ownership inviata'
    end
  end

end
