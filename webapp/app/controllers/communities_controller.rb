class CommunitiesController < PagesController
  
  def index
    if params[:query]
      @pages = Page.communities.where("name LIKE ? and active = 1", "%#{params[:query]}%")
    else
      @pages = Page.communities.where("active = 1")
    end
  end

  def typeahead
    @search  = Page.communities.where("name LIKE ? and active = 1", "%#{params[:query]}%")
    render json: @search
  end

  def show
  end
end
