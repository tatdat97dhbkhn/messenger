class MessagesController < ApplicationController
  before_action :set_channel, only: %i[create]
  before_action :set_conversation, only: %i[create]

  def create
    @form = MessageForm.new(params: params, messages: @conversation.messages)

    if @form.submit
      ActionCable.server.broadcast "channel:#{@channel.id}", {
        sender_message: ApplicationController.render(partial: 'chat/content/sender/message',
                                                     locals: { conversation: @conversation,
                                                               message: @form.message }),
        recipient_message: ApplicationController.render(partial: 'chat/content/receiver/message',
                                                        locals: { conversation: @conversation,
                                                                  message: @form.message }),
        sender_id: current_user.id
      }
    else
      flash.now[:error] = @form.errors.full_messages
    end
  end

  private

  def set_channel
    channel_type = "#{params.dig(:message_form, :channel_type).presence || Channel.types[:just_two_people]}_type"
    @channel = Channel.send(channel_type).find_by(id: params[:channel_id])
  end

  def set_conversation
    last_conversation = @channel.conversations.order(created_at: :desc)
    @conversation = last_conversation.first

    if @conversation.nil? || Time.current > @conversation.end_time
      @conversation = @channel.conversations.create(end_time: Time.current + 30.minutes)
    end
  end
end
