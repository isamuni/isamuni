class Me::OwnershipRequestsController < ApplicationController

  def create
    p = Page.find(params[:page])
    if p.owners.include? current_user
      render text: 'Hai già la ownership per questa pagina', status: 404
    else
      OwnershipRequest.create!(page_id: p.id, user_id: current_user.id)
      render text: 'Richiesta di ownership inviata'
    end
  end

end
