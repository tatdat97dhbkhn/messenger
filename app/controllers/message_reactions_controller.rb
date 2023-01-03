# frozen_string_literal: true

# This is your message_reactions controller
class MessageReactionsController < ApplicationController
  before_action :set_channel, only: %i[index create]
  before_action :set_message, only: %i[index create]

  def index
    @message_reactions = @message.message_reactions
  end

  def create
    @form = MessageReactionForm.new(params:, user_id: current_user.id)

    flash.now[:error] = @form.errors.full_messages unless @form.submit
  end

  private

  def set_channel
    @channel = Channel.find_by(id: params[:channel_id])
  end

  def set_message
    @message = @channel.messages.eager_load(message_reactions: { user: { avatar_attachment: :blob } })
                       .find_by(id: params[:message_id])
  end
end
