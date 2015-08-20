class ApplicationController < ActionController::Base
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  after_filter :track_action

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

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def track_action

    # we want to only log strings, so filter out anything that can't be recognised as UTF-8
    encoded_filtered_params = Hash[
        request.filtered_parameters.collect do |k, v|
          if (v.respond_to?(:encoding))
            [ k, v.dup.encode('UTF-8', {:invalid => :replace, :undef => :replace, :replace => '?'}) ]
          else
            # it's not a string, so it's likely an image so don't try and encode it
          end
        end
    ]

    ahoy.track "Processed #{controller_name}##{action_name}", encoded_filtered_params
  end

end
