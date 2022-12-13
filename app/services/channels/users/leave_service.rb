module Channels
  module Users
    class LeaveService < ApplicationService
      parameters :current_user, :channel

      def call
        joinable = channel.joinables.find_by(user_id: current_user.id)

        if joinable.destroy
          create_message_notice
          set_creator if current_user.id == channel.creator_id
        else
          @errors = joinable.errors.full_messages
        end
      end

      private

      def set_creator
        first_user = channel.joined_users.first
        channel.update(creator_id: first_user&.id)
      end

      def create_message_notice
        messages_create_service = Messages::CreateService.call(
          user_id: current_user.id,
          body: "#{current_user.name} has left the channel",
          type: Message.types[:notice],
          channel: channel,
          allow_broadcast_new_message: true
        )

        raise ActiveRecord::Rollback if messages_create_service.fail?
      end
    end
  end
end
