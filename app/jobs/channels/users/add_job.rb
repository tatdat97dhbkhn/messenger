# frozen_string_literal: true

module Channels
  module Users
    # This is your channels/users/add job
    class AddJob < ApplicationJob
      queue_as :default

      def perform(**options)
        ActionCable.server.broadcast "list_channels:user-#{options[:user].id}", {
          channel_partial: channel_partial(**options),
          channel_id: options[:channel].id,
          is_new_channel: true,
          sender_id: options[:current_user].id,
          type: 'add'
        }
      end

      private

      def channel_partial(**options)
        ApplicationController.render(
          partial: 'chat/channels/channel',
          locals: {
            channel: options[:channel],
            user: options[:user]
          }
        )
      end
    end
  end
end
