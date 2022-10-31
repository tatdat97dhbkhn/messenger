class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      Users::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
