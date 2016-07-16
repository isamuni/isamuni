class ProfileController < ApplicationController
  before_action :set_user, only: [:show, :update]

  # GET /users/typeahead?query=text
  def typeahead
    @search  = UserSearch.new(typeahead: params[:query])
    render json: @search.results
  end

  # GET /users/query/name
  # GET /users?query=text
  def index
    @search = UserSearch.new(search_params)
    @users = search_params.present? ? @search.results : User.all
  end

  # GET /users/:id
  def show
    set_user
    @posts = Post.where(author_uid: @user.uid).limit(30).order('created_at desc')
  end

  def new
    @user = User.new
  end

  # GET /me
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(post_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
    else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if current_user.update(post_params)
        format.html { redirect_to current_user, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # FIXME - Remove private params before deploying the application - These are here only for test purposes
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:user).permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at, :description, :projects, :links)
    end

    def search_params
      params[:user_search].presence || {}
    end

end
