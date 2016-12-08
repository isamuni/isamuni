# frozen_string_literal: true
class CompaniesController < PagesController
  layout 'application'

  def index
    if params[:query]
      @pages = Page.companies.ilike(:name, params[:query]).where(active: true)
    else
      @pages = Page.companies.where(active: true)
    end

    @pages = @pages.order(:name)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @pages }
    end
  end

  def typeahead
    @search = Page.companies.ilike(:name, params[:query]).where(active: true)
    render json: @search
  end
end
