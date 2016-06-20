class ProfileController < ApplicationController
  before_action :set_post, only: [:show, :update]

  # GET /users/query/name
  # GET /users?query=text
  def index 
      if params[:query]
          @users = User.where(User.arel_table[:name].matches('%' + params[:query] + '%'))
      else
          @users = User.all
      end
  end

  # GET /users/:uid
  def show
    @user = User.find(params[:uid])
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
    def set_post
      @user = User.find(params[:uid])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:user).permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at, :description, :projects, :links)
    end

end
