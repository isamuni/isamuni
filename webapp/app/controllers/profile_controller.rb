class ProfileController < ApplicationController
  before_action :set_user, only: [:show, :update, :all_posts]
  before_action :check_logged_in, only: [:edit, :update]

  # GET /users/typeahead?query=text
  def typeahead
    @search  = UserSearch.new(typeahead: params[:query])
    render json: @search.results
  end

  # GET /users/query/name
  # GET /users?query=text
  def index
    @search = UserSearch.new(search_params)
    @users = search_params.present? ? @search.results : User.where(:banned => false)

    respond_to do |format|
        format.html { render :index}
        format.json { render json: @users }
    end
  end

  # GET /users/:id
  # FIXME - do not show if user is banned
  def show
    @posts = Post.where(author_uid: @user.uid, show: true).limit(5).order('created_at desc')
    @count = Post.where(author_uid: @user.uid, show: true).count()
  end

  def new
    @user = User.new
  end

  # GET /me
  def edit
    render :edit, layout: "user_area"
  end

  # GET /users/:id/all_posts
  def all_posts
    @posts = Post.where(author_uid: @user.uid, show: true).order('created_at desc')
  end

  # POST /users
  # POST /users.json
  # def create
  #   @user = User.new(post_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if current_user.update(post_params)
        format.html { redirect_to current_user, notice: 'User was successfully updated.' }
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
      if @user.banned
        require_admin
      end
    end

    # FIXME - Remove private params before deploying the application - These are here only for test purposes
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:user).permit(:provider, :uid, :name, :oauth_token, 
                                    :oauth_expires_at, :occupation, 
                                    :description, :projects, :links)
    end

    def search_params
      params[:user_search].presence || {}
    end

end
