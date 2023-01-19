class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include ApplicationHelper
  respond_to :json, :html

  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def user_not_authorized
    flash[:alert] = t("flash.pundit.unauthorized")
    redirect_back(fallback_location: root_path)
  end
end
