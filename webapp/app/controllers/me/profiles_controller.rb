class Me::ProfilesController < ApplicationController
  layout 'user_area'
  before_action :check_logged_in

  def update
    current_user.assign_attributes(post_params)
    respond_to do |format|
      if current_user.save(context: :manual_update)
        format.html { redirect_to current_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit, layout: 'user_area' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    render :edit, layout: 'user_area'
  end

private

  def post_params
    params.require(:user).permit(:name, :occupation, :description,
                                 :projects, :links, :skill_list, :public_profile, :email)
  end

end
