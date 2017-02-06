# frozen_string_literal: true
class ProfileController < ApplicationController
  before_action :set_user, only: [:show, :all_posts]

  # GET /users/typeahead?query=text
  def typeahead
    @search = UserSearch.new(typeahead: params[:query])
    render json: @search.results
  end

  # GET /users/query/name
  # GET /users?query=text
  def index
    @search = UserSearch.new(search_params)
    @users = search_params.present? ? @search.results : User.where(banned: false)
    @users = @users.order(:name)
    @tags = User.tag_counts_on(:skills)

    @latest_users = User.where(banned: false).limit(3).order('created_at desc')

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @users }
    end
  end

  #GET /profile/skills?id=skill_id
  def skills 
    @search = UserSearch.new(search_params)  
    @current_skill = params[:id]
    @users = User.where(banned: false).tagged_with(@current_skill)
    @users = @users.order(:name)
    @tags = User.tag_counts_on(:skills)

    #@latest_users = User.where(banned: false).limit(3).order('created_at desc')

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
