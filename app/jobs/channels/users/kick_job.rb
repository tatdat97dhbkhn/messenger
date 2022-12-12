module Channels
  module Users
    class KickJob < ApplicationJob
      queue_as :default

      def perform(**options)
        ActionCable.server.broadcast "list_channels:user-#{options[:user].id}", {
          type: 'kick',
          sender_id: options[:current_user].id,
          channel_id: options[:channel].id
        }
      end
    end
  end
end
