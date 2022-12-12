module Channels
  module Users
    class AddJob < ApplicationJob
      queue_as :default

      def perform(**options)
        ActionCable.server.broadcast "list_channels:user-#{options[:user].id}", {
          channel_partial: ApplicationController.render(
            partial: 'chat/channels/channel',
            locals: {
              channel: options[:channel],
              user: options[:user]
            }
          ),
          channel_id: options[:channel].id,
          is_new_channel: true,
          sender_id: options[:current_user].id
        }
      end
    end
  end
end
