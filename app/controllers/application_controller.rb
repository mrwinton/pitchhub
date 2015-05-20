class ApplicationController < ActionController::Base
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :first_name, :last_name, :password, :password_confirmation, :address)}
  end

  def layout_by_resource
    if devise_controller?
      "devise/base"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
   return "/"
  end

  def after_sign_out_path_for(resource)
    return "/"
  end

end
