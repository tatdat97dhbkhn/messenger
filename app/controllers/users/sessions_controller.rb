module Users
  class SessionsController < Devise::SessionsController
    layout 'application'

    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      resource.online!
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    def destroy
      ActionCable.server.remote_connections.where(current_user: current_user).disconnect
      current_user.offline!

      super
    end
  end
end
