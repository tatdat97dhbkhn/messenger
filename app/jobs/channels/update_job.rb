module Channels
  class UpdateJob < ApplicationJob
    queue_as :default

    def perform(**options)
      ActionCable.server.broadcast "latest_message_channel:#{options[:channel].id}",
                                   { type: options[:type] }.merge(send("#{options[:type] }_data", **options))
    end

    private

    def update_photo_data(**options)
      {
        channel_id: options[:channel].id,
        photo_partial: ApplicationController.render(
          partial: 'channels/photo',
          locals: {
            channel: options[:channel]
          }
        )
      }
    end

    def update_name_data(**options)
      {
        channel_name: options[:channel].name,
        channel_id: options[:channel].id,
      }
    end

    def update_latest_message_data(**options)
      {
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
