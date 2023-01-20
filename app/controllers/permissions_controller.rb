class PermissionsController < ApplicationController
  before_action :authenticate_user

  def auth_header
    request.headers['Authorization']
  end

  def authenticate_user
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      # binding.pry
      jwt_payload = JWT.decode(token, 'vicSecret', true, algorithm: 'HS256').first
      @current_user_id = jwt_payload['id']
    end
  end

  def authenticate_user!(_options = {})
    render json: { loggedIn: false, result: [], message: 'Please log in to continue' } unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  rescue StandardError
    head :unauthorized
  end

  def signed_in?
    @current_user_id.present?
  end

  def only_admin
    if current_user.is_admin?
      action = params[:action]
    else
      render json: { error: "Only the admin can perform this action" }, status: :unauthorized
    end
  end
end
