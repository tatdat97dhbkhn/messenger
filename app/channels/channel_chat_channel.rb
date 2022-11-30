class ChannelChatChannel < ApplicationCable::Channel
  def subscribed
    return unless params[:channel_id].present?

    channel.add_user_to_connected_user_ids!(current_user.id)
    stream_from("channel:#{params[:channel_id]}")
  end

  def unsubscribed
    return unless params[:channel_id].present?

    channel.remove_user_to_connected_user_ids!(current_user.id)
    stop_stream_from("channel:#{params[:channel_id]}")
  end

  def channel
    @channel = Channel.find_by(id: params[:channel_id])
  end
end
