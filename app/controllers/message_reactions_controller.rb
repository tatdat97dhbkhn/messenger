class MessageReactionsController < ApplicationController
  before_action :set_channel, only: :create
  before_action :set_message, only: :create

  def create
    @form = MessageReactionForm.new(params: params, user_id: current_user.id)

    flash.now[:error] = @form.errors.full_messages unless @form.submit
  end

  private

  def set_channel
    @channel = Channel.find_by(id: params[:channel_id])
  end

  def set_message
    @message = @channel.messages.find_by(id: params[:message_id])
  end
end
