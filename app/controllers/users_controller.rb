class UsersController < ApplicationController

  before_action(:authenticate_user!) || before_action(:authenticate_admin!)
  before_action :set_user

  def show
  end

  def edit
  end

  def edit_password
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "User updated."
    else
      render :edit
    end
  end
  
  def update_password
    @user.update_password = true
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "Password updated."
    else
      render :edit_password
    end
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end

end