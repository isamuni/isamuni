# frozen_string_literal: true
class ProfileController < ApplicationController
  before_action :set_user, only: [:show, :all_posts]

  # GET /users/typeahead?query=text
  def typeahead
    render json: User.where(banned: false).ilike(:name, params[:query])
  end

  # GET /users/query/name
  # GET /users?query=text
  def index
    @users = User.where(banned: false).order(:name).includes(:skills)

    @users = @users.ilike(:name, params[:query]) unless params[:query].blank?
    @users = @users.tagged_with(params[:skills]) unless params[:skills].blank?

    @tags = User.tag_counts_on(:skills)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @users }
    end
  end

  # GET /users/:id
  def show
    @count = Post.where(author_uid: @user.uid, show: true).count
  end

  def new
    @user = User.new
  end

  # GET /users/:id/all_posts
  def all_posts
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
    require_admin if @user.banned
  end

  def search_params
    params[:user_search].presence || {}
  end
end
