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

    NotificationMailer.page_edit_notification(current_user, @page).deliver_later if correctly_saved

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

  def edit

  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    page_updated = @page.update(page_params)
    NotificationMailer.page_edit_notification(current_user, @page).deliver_later if page_updated    

    respond_to do |format|
      if page_updated
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
    redirect_to controller: 'me/ownership_requests', action: :new, page: @page.id unless current_user&.is_admin? or @page.owners.include?(current_user)
  end

  def set_page
    @page = Page.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:name, :links, :description, :contacts, :sector,
                                 :kind, :fbpage, :twitterpage, :location,
                                 :lookingfor, :no_employees, :website)
  end
end
