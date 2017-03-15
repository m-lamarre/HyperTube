class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_sign_up_parameters, if: :devise_controller?
  before_action :configure_permitted_sign_in_parameters, if: :devise_controller?

  protected

    def configure_permitted_sign_up_parameters
      added_attrs = [:username, :first_name, :last_name, :email, :password, :password_confirmation]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    def configure_permitted_sign_in_parameters
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:username, :email, :password)
      end
    end
end
