module Api
  class UsersController < PermissionsController
    before_action :authenticate_user!

    def show; end

    def update
      if current_user.update!(user_params)
        render json: {
          user: current_user
        }
      else
        render json: { errors: current_user.errors }, status: :unprocessable_entity
      end
    end

    # def auto_login
    #   render json: {
    #     user: current_user,
    #     profile: current_user.profile,
    #     profile_role: current_user.profile.profile_role ? current_user.profile.profile_role : nil,
    #     talent:  current_user.profile.profile_role.talent ? current_user.profile.profile_role.talent : nil,
    #     company:  current_user.profile.profile_role.company ? current_user.profile.profile_role.company : nil,
    #     investor:  current_user.profile.profile_role.investor ? current_user.profile.profile_role.investor : nil
    #   }
    # end

    private

    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
  end
end
