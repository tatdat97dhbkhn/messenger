class LatestMessageChannel < ApplicationCable::Channel
  def subscribed
    return unless params[:channel_id].present?

    stream_from("latest_message_channel:#{params[:channel_id]}")
  end

  def unsubscribed
    return unless params[:channel_id].present?

    stop_stream_from("latest_message_channel:#{params[:channel_id]}")
  end
end
