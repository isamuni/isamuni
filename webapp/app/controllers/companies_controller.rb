class CompaniesController < PagesController

  def index
    if params[:query]
      @pages = Page.companies.where("name LIKE ?", "%#{params[:query]}%")
    else
      @pages = Page.companies
    end
  end

  def typeahead
    @search = Page.companies.where("name LIKE ?", "%#{params[:query]}%")
    render json: @search
  end

  def show
  end

end
