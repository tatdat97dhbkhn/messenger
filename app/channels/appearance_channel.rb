# frozen_string_literal: true

# This is your appearance channel
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearance_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_stream_from 'appearance_channel'
    offline
  end

  def online
    current_user.online!
  end

  def away
    current_user.away!
  end

  def offline
    current_user.offline!
  end

  def receive(data)
    ActionCable.server.broadcast('appearance_channel', data)
  end
end
