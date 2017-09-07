# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @pages = Page.where(active: true).order(:name)

    if params[:query]
      @pages = @pages.ilike(:name, params[:query]).where(active: true)
    end

    if params[:kind]
      kind = params[:kind].to_sym
      @pages = @pages.where(kind: Page.kinds[kind])
    end

    respond_to do |format|
      format.html do
        if kind == :company
          render :companies
        elsif kind == :community
          render :communities
        else
          render :index
        end
      end
      format.json do
        if params[:names_only]
          render json: @pages.as_json(only: %i[name id])
        else
          render json: @pages
        end
      end
    end
  end

  def typeahead
    @pages = Page.ilike(:name, params[:query]).where(active: true)

    if params[:kind]
      kind = params[:kind].to_sym
      @pages = @pages.where(kind: Page.kinds[kind])
    end

    render json: @pages
  end

  def show
    @page = Page.friendly.find(params[:id])
    @owners = User.where(id: @page.owners, public_profile: true)
  end
end
