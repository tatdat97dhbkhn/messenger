# frozen_string_literal: true

module Channels
  # This is your channels/create job
  class CreateJob < ApplicationJob
    queue_as :default

    def perform(**options)
      channel_id = options[:channel].id

      options[:channel].joined_users.find_each do |user|
        ActionCable.server.broadcast "list_channels:user-#{user.id}", {
          channel_partial: channel_partial(user, **options),
          channel_id:,
          is_new_channel: options[:is_new_channel],
          sender_id: options[:current_user].id
        }
      end
    end

    private

    def channel_partial(user, **options)
      ApplicationController.render(
        partial: 'chat/channels/channel',
        locals: {
          channel: options[:channel],
          user:
        }
      )
    end
  end
end
