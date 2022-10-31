module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'application'

    def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          flash[:notice] = 'Account registration is successful, please check your email to confirm'
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        flash.now[:error] = resource.errors.full_messages
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end
end
