class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      Users::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
