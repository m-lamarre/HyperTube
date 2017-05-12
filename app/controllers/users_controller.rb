class UsersController < ApplicationController
  def new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = 'Profile Updated'
      render 'show'
    else
      flash[:alert]
      render 'devise/registrations/edit'
    end
  end

private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :profile_picture
    )
  end

end
