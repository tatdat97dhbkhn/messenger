class ChatController < ApplicationController
  def index
    @channels = Channels::FilterService.call(params: params, channels: channel_scope)
      .channels
      .order('channels.last_message_sent_at DESC, channels.created_at DESC')
  end

  private

  def channel_scope
    Channel.includes({ joinables: { user: [:avatar_attachment] } }, { photo_attachment: :blob })
           .where(users: { id: current_user.id })
  end
end
