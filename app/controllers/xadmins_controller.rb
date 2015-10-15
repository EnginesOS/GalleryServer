class AdminsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_admin

  def show
  end

  def edit
  end

  def edit_password
  end

  def update
    if @admin.update(admin_params)
      redirect_to admin_path(@admin.id), notice: "Admin updated."
    else
      render :edit
    end
  end
  
  def update_password
    @admin.update_password = true
    if @admin.update(admin_params)
      redirect_to admin_path(@admin.id), notice: "Password updated."
    else
      render :edit_password
    end
  end
  
  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit!
  end

end