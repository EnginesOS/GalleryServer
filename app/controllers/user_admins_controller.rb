class UserAdminsController < ApplicationController

  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def ban
    @user = User.find(params[:id])
    @user.update(banned: true)
    redirect_to user_admin_path(@user)
  end

  def unban
    @user = User.find(params[:id])
    @user.update(banned: false)
    redirect_to user_admin_path(@user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Successfully updated user."
    else
      redirect_to edit_user_admin_path(user_params)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_admins_path, notice: "Successfully destroyed user."
  end

private

  def user_admin_params
    params.require(:user_admin).permit!
  end

end
