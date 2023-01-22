module Api
  class SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token

    def create
      user = User.find_by_email(params['user']['email'])

      if user&.valid_password?(params['user']['password'])
        @current_user = user
        if user.requires_confirmation?
          render json: { message: 'Please confirm your registered email to access your account.' },
                 status: 401 and return
        else
          # render the template for the user
          render json: { user: { id: user.id, email: user.email, name: user.name, role: user.role.name, token: user.generate_jwt } }
          # render 'api/users/current_user', status: :created
        end
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end
  end
end
