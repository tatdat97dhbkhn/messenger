# frozen_string_literal: true

module MessageNotifications
  class ReadJob < ApplicationJob
    queue_as :default

    def perform(**options)
      message_notifications = options[:channel].message_notifications.unread_by_user(options[:user_id])
      message_notifications.update_all(read_at: Time.zone.now)
    end
  end
end
