class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  require "awesome_print"

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def authenticate_user! opts={}
    if user_signed_in?
      if current_user.banned #current_user && 
        render text: "Sorry. There is a ban on this account."
      else
        super opts
      end
    elsif admin_signed_in?
      super opts
    else
      redirect_to root_path
    end
  end
  
  def after_sign_in_path_for(resource)
    published_softwares_path
  end

end
