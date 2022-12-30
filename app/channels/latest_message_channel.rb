# frozen_string_literal: true

# This is your latest message channel
class LatestMessageChannel < ApplicationCable::Channel
  def subscribed
    return if params[:channel_id].blank?

    stream_from("latest_message_channel:#{params[:channel_id]}")
  end

  def unsubscribed
    return if params[:channel_id].blank?

    stop_stream_from("latest_message_channel:#{params[:channel_id]}")
  end
end
