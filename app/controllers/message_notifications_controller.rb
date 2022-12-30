# frozen_string_literal: true

# This is your message_notifications controller
class MessageNotificationsController < ApplicationController
  before_action :set_channel, only: :create
  before_action :set_message, only: :create

  def create
    MessageNotifications::CreateJob.perform_later(user_id: params[:user_id], message: @message, channel: @channel)
  end

  private

  def set_channel
    @channel = Channel.find_by(id: params[:channel_id])
  end

  def set_message
    @message = @channel.messages.find_by(id: params[:message_id])
  end
end
