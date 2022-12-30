# frozen_string_literal: true

module Channels
  module Users
    # This is your channels/users/kick service
    class KickService < ApplicationService
      parameters :user, :current_user, :channel

      def call
        joinable = channel.joinables.find_by(user_id: user.id)

        if joinable.destroy
          create_message_notice
          Channels::Users::KickJob.perform_later(
            channel:,
            current_user:,
            user:
          )
        else
          @errors = joinable.errors.full_messages
        end
      end

      private

      def create_message_notice
        messages_create_service = Messages::CreateService.call(
          user_id: current_user.id,
          body: "#{current_user.name} kicked #{user.name} out of the channel",
          type: Message.types[:notice],
          channel:,
          allow_broadcast_new_message: true
        )

        raise ActiveRecord::Rollback if messages_create_service.fail?
      end
    end
  end
end
