# frozen_string_literal: true

module Channels
  class UpdateLatestMessageJob < ApplicationJob
    queue_as :default

    def perform(**options)
      options[:channel].update(last_message_sent_at: Time.current)

      ActionCable.server.broadcast "latest_message_channel:#{options[:channel].id}", {
        latest_message: ApplicationController.render(
          partial: 'chat/channels/latest_message',
          locals: {
            channel: options[:channel].decorate
          }
        ),
        read: ApplicationController.render(
          partial: 'chat/channels/read_latest_message',
          locals: {
            user: options[:channel].joined_users.where.not(joinables: { user_id: options[:sender_id] }).first
          }
        ),
        unread: ApplicationController.render(partial: 'chat/channels/unread_latest_message'),
        sender_id: options[:sender_id] ,
        channel_id: options[:channel].id,
        connected_user_ids: options[:channel].connected_user_ids,
        message_id: options[:message].id,
      }
    end
  end
end
