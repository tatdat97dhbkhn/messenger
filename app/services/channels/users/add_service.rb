# frozen_string_literal: true

module Channels
  module Users
    # This is your channels/users/add service
    class AddService < ApplicationService
      parameters :user, :current_user, :channel

      def call
        ActiveRecord::Base.transaction do
          create_message_notice
          create_joinables(user)

          Channels::Users::AddJob.perform_later(
            channel: @channel,
            current_user:,
            user:
          )
        rescue StandardError => e
          @errors = [e.message]
        end
      end

      private

      def create_joinables(user)
        channel.joinables.create!(user_id: user.id)
      end

      def create_message_notice
        messages_create_service = Messages::CreateService.call(
          user_id: current_user.id,
          body: "#{current_user.name} added #{user.name} to the channel",
          type: Message.types[:notice],
          channel:,
          allow_broadcast_new_message: true
        )

        raise ActiveRecord::Rollback if messages_create_service.fail?
      end
    end
  end
end
