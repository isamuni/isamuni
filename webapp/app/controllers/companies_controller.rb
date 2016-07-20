class CompaniesController < PagesController

  def index
    if params[:query]
      @pages = Page.companies.where("name LIKE ? and active = ?", "%#{params[:query]}%", true)
    else
      @pages = Page.companies.where("active = ?", true)
    end
  end

  def typeahead
    @search = Page.companies.where("name LIKE ? and active = ?", "%#{params[:query]}%", true)
    render json: @search
  end

  def show
  end

end
