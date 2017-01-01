# frozen_string_literal: true
class Me::PagesController < ApplicationController
  layout 'user_area'
  before_action :check_logged_in

  before_action :set_page, only: [:edit, :update, :destroy]
  before_action :check_page_owner, only: [:edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    return check_logged_in unless current_user
    @pages = current_user.pages
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    @page.active = false
    @page.owner_id = current_user.id # TODO: - deprecate this in favour of @page.owners
    @page.owners << current_user
    correctly_saved = @page.save

    respond_to do |format|
      if correctly_saved
        format.html { redirect_to @page, notice: 'Page was successfully requested. Wait for an admin to approve it' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def check_page_owner
    redirect_to '/', notice: 'Only a page owner can edit a page' unless current_user&.is_admin? || @page.owners.include?(current_user)
  end

  def set_page
    @page = Page.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:name, :links, :description, :contacts, :sector,
                                 :kind, :fbpage, :twitterpage, :location,
                                 :lookingfor, :no_employees, :url)
  end
end
