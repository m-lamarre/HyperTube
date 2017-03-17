class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_sign_up_parameters, if: :devise_controller?
  before_action :configure_permitted_sign_in_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, if: :devise_controller?

  def user_params
    [:username, :first_name, :last_name, :email, :password, :password_confirmation]
  end

  protected

    def configure_permitted_sign_up_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: user_params
    end

    def configure_permitted_sign_in_parameters
      devise_parameter_sanitizer.permit :sign_in, keys: [:username, :email, :password]
    end

    def configure_account_update_parameters
      devise_parameter_sanitizer.permit :account_update, keys: user_params
    end
end
