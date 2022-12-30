# frozen_string_literal: true

module MessageNotifications
  # This is your message_notifications/create service
  class CreateService < ApplicationService
    parameters :message, :users

    def call
      current = Time.current
      message_id = message.id
      message_notifications_attributes = []

      users.find_each do |user|
        message_notifications_attributes.push({
                                                user_id: user.id,
                                                message_id:,
                                                created_at: current,
                                                updated_at: current
                                              })
      end

      # rubocop:disable Rails/SkipsModelValidations
      MessageNotification.insert_all!(message_notifications_attributes)
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
