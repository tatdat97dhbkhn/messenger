# frozen_string_literal: true

module MessageNotifications
  # This is your message_notifications/read job
  class ReadJob < ApplicationJob
    queue_as :default

    def perform(**options)
      message_notifications = options[:channel].message_notifications.unread_by_user(options[:user_id])
      # rubocop:disable Rails/SkipsModelValidations
      message_notifications.update_all(read_at: Time.zone.now)
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
