class ProfileController < ApplicationController
    before_action :set_user, only: [:show, :update, :all_posts]
    before_action :check_logged_in, only: [:edit, :update]

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

        @latest_users = User.where(banned: false).limit(3).order('created_at desc')

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

    # GET /me
    def edit
        render :edit, layout: 'user_area'
    end

    # GET /users/:id/all_posts
    def all_posts
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
        respond_to do |format|
            if current_user.update(post_params)
                format.html { redirect_to current_user, notice: 'User was successfully updated.' }
                format.json { render :show, status: :ok, location: current_user }
            else
                format.html { render :edit, layout: 'user_area' }
                format.json { render json: current_user.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.friendly.find(params[:id])
        require_admin if @user.banned
    end

    def post_params
        params.require(:user).permit(:name, :occupation, :description, 
                                        :projects, :links, :tags)
    end

    def search_params
        params[:user_search].presence || {}
    end
end
