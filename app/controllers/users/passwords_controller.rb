# frozen_string_literal: true

module Users
  # This is your users/passwords controller
  class PasswordsController < Devise::PasswordsController
    layout 'application'
  end
end
