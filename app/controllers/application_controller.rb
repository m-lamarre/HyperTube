class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_sign_up_parameters, if: :devise_controller?
  before_action :configure_permitted_sign_in_parameters, if: :devise_controller?

  protected

    def configure_permitted_sign_up_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name])
    end

    def configure_permitted_sign_in_parameters
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:username, :email)
      end
    end
end
