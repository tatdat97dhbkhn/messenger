# frozen_string_literal: true

module MessageNotifications
  class CreateJob < ApplicationJob
    queue_as :default

    def perform(**options)
      users = if options[:not_user_id].present?
        options[:channel]
          .joined_users
          .where.not(
          joinables: {
            user_id: [ options[:not_user_id], options[:channel].connected_user_ids ].flatten
          }
        )
      elsif options[:user_id].present?
        User.where(id: options[:user_id])
      else
        []
      end


      return if users.blank?

      MessageNotifications::CreateService.call(message: options[:message], users: users)
    end
  end
end
