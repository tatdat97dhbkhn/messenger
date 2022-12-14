# frozen_string_literal: true

module Users
  # This is your users/registrations controller
  class RegistrationsController < Devise::RegistrationsController
    layout 'application'

    # rubocop:disable Metrics/AbcSize
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
          flash[:notice] = t('devise.registrations.signed_up_but_unconfirmed')
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
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    protected

    def after_inactive_sign_up_path_for(resource)
      scope = Devise::Mapping.find_scope!(resource)
      router_name = Devise.mappings[scope].router_name
      context = router_name ? send(router_name) : self

      context.new_user_session_path
    end
  end
end
