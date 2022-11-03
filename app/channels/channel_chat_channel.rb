class ChannelChatChannel < ApplicationCable::Channel
  def subscribed
    return unless params[:channel_id].present?

    stream_from("channel:#{params[:channel_id]}")
  end

  def unsubscribed
    stop_stream_from("channel:#{params[:channel_id]}")
  end
end
