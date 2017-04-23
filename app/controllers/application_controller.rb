class ApplicationController < ActionController::Base

  #@user = User.new
  #@user = current_user

  before_action :configure_permitted_parameters, if: :devise_controller?	

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do 
  	redirect_to root_path, notice: "Record not found"
  end

  def check_is_admin
  	if current_user.is_admin
  		return true
  	else
  		redirect_to root_path, notice: "Page you are looking for does not exist"
  	end

  end


  protected

  def configure_permitted_parameters

   #devise_parameter_sanitizer.for(:sign_in)        << :username
   devise_parameter_sanitizer.for(:sign_up)        << :username
   #devise_parameter_sanitizer.for(:account_update) << :username

  	#devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
