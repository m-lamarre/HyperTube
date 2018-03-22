class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :basic_auth

  private

  def basic_auth
    if Rails.application.secrets.http_basic_user and Rails.application.secrets.http_basic_pass
      authenticate_or_request_with_http_basic do |username, password|
        username == Rails.application.secrets.http_basic_user && password == Rails.application.secrets.http_basic_pass
      end
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i(username first_name last_name email password password_confirmation remember_me)
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
