class CommunitiesController < PagesController
  
  def index
    if params[:query]
      @pages = Page.communities.where("name LIKE ? and active = ?", "%#{params[:query]}%", true)
    else
      @pages = Page.communities.where("active = ?", true)
    end
  end

  def typeahead
    @search  = Page.communities.where("name LIKE ? and active = ?", "%#{params[:query]}%", true)
    render json: @search
  end

  def show
  end
end
