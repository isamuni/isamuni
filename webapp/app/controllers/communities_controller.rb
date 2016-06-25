class CommunitiesController < PagesController
  def index
    if params[:query]
      @pages = Page.communities.where("name LIKE ?", "%#{params[:query]}%")
    else
      @pages = Page.communities
    end
  end

  def typeahead
    @search  = Page.communities.where("name LIKE ?", "%#{params[:query]}%")
    render json: @search
  end

  def show
  end
end
