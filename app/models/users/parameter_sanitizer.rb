module Users
  class ParameterSanitizer < Devise::ParameterSanitizer
    # https://github.com/heartcombo/devise/tree/v4.8.0#strong-parameters
    def initialize(resource_class, resource_name, params)
      super

      permit(:sign_in) do |user_params|
        user_params.permit(:email, :password)
      end

      permit(:sign_up) do |user_params|
        user_params.permit(:avatar, :email, :name, :password, :password_confirmation)
      end
    end
  end
end
