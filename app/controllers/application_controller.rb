class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_current_user

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def set_current_user
    Current.user ||= current_user
  rescue
    Current.user = nil
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
