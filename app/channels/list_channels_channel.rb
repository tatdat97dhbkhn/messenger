class ListChannelsChannel < ApplicationCable::Channel
  def subscribed
    stream_from("list_channels:user-#{current_user.id}")
  end

  def unsubscribed
    stop_stream_from("list_channels:user-#{current_user.id}")
  end
end
