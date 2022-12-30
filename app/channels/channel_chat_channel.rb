# frozen_string_literal: true

# This is your chat channel
class ChannelChatChannel < ApplicationCable::Channel
  def subscribed
    return if params[:channel_id].blank?

    channel.add_user_to_connected_user_ids!(current_user.id)
    stream_from("channel:#{params[:channel_id]}")
  end

  def unsubscribed
    return if params[:channel_id].blank?

    channel.remove_user_to_connected_user_ids!(current_user.id)
    stop_stream_from("channel:#{params[:channel_id]}")
  end

  def channel
    @channel = Channel.find_by(id: params[:channel_id])
  end
end
