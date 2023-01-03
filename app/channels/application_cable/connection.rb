# frozen_string_literal: true

module ApplicationCable
  # This is your application cable connection
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      env['warden'].user || reject_unauthorized_connection
    end
  end
end
