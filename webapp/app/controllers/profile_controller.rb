class ProfileController < ApplicationController
 
  # POST /users
  # POST /users.json
  def create
    @user = User.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
    else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /me
  def edit
  end

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

  def delete
  end

end
