# frozen_string_literal: true

module MessageNotifications
  # This is your message_notifications/create job
  class CreateJob < ApplicationJob
    queue_as :default

    def perform(**options)
      users = if options[:not_user_id].present?
                not_user_id(**options)
              elsif options[:user_id].present?
                with_user_id(**options)
              else
                []
              end

      return if users.blank?

      MessageNotifications::CreateService.call(message: options[:message], users:)
    end

    private

    def with_user_id(**options)
      User.where(id: options[:user_id])
    end

    def not_user_id(**options)
      options[:channel]
        .joined_users
        .where.not(
          joinables: {
            user_id: [options[:not_user_id], options[:channel].connected_user_ids].flatten
          }
        )
    end
  end
end
