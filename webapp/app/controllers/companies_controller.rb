class CompaniesController < PagesController

  def index
    if params[:query]
      @pages = Page.companies.where("name LIKE ? and active = 1", "%#{params[:query]}%")
    else
      @pages = Page.companies.where("active = 1")
    end
  end

  def typeahead
    @search = Page.companies.where("name LIKE ? and active = 1", "%#{params[:query]}%")
    render json: @search
  end

  def show
  end

end
