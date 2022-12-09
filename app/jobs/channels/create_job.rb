# frozen_string_literal: true

module Channels
  class CreateJob < ApplicationJob
    queue_as :default

    def perform(**options)
      channel_id = options[:channel].id

      options[:channel].joined_users.find_each do |user|
        ActionCable.server.broadcast "list_channels:user-#{user.id}", {
          channel_partial: ApplicationController.render(
            partial: 'chat/channels/channel',
            locals: {
              channel: options[:channel],
              user: user
            }
          ),
          channel_id: channel_id,
          is_new_channel: options[:is_new_channel],
          sender_id: options[:current_user].id
        }
      end
    end
  end
end
