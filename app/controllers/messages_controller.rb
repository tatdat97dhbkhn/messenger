# frozen_string_literal: true

# This is your messages controller
class MessagesController < ApplicationController
  before_action :set_channel, only: %i[create]

  def create
    @form = MessageForm.new(params:, messages: @channel.messages, channel: @channel)
    @message_reaction_form = MessageReactionForm.new

    if @form.submit
      broadcast_append_messages
    else
      flash.now[:error] = @form.errors.full_messages
    end
  end

  private

  def channel_type
    case params.dig(:message_form, :channel_type)
    when Channel.types[:public]
      Channel.types[:public]
    when Channel.types[:private]
      Channel.types[:private]
    else
      Channel.types[:just_two_people]
    end
  end

  def set_channel
    @channel = Channel.send("#{channel_type}_type").find_by(id: params[:channel_id])
  end

  def broadcast_append_messages
    MessageBroadcastJob.perform_now(
      channel: @channel,
      messages: @form.new_messages,
      message_reaction_form: @message_reaction_form,
      current_user:
    )
  end
end
