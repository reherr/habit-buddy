class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization
  after_action :verify_authorized, unless: :skip_these?
  before_action :authenticate_user!, unless: :home_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back fallback_location: root_url && return
  end

  def skip_these?
    devise_controller? || home_controller?
  end

  def home_controller?
    controller_name == 'home'
  end
end
