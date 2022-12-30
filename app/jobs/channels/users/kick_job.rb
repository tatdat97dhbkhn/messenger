# frozen_string_literal: true

module Channels
  module Users
    # This is your channels/users/kick job
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
