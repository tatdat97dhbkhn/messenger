class MessagesController < ApplicationController
  before_action :set_channel, only: %i[create]
  before_action :set_conversation, only: %i[create]

  def create
    @form = MessageForm.new(params: params, messages: @conversation.messages)
    @message_reaction_form = MessageReactionForm.new

    if @form.submit
      if @is_new_conversation
        broadcast_append_conversations
        sleep 0.2
      end

      broadcast_append_messages
    else
      @conversation.destroy if @is_new_conversation

      flash.now[:error] = @form.errors.full_messages
    end
  end

  private

  def set_channel
    channel_type = "#{params.dig(:message_form, :channel_type).presence || Channel.types[:just_two_people]}_type"
    @channel = Channel.send(channel_type).find_by(id: params[:channel_id])
  end

  def set_conversation
    conversations_create_service = Conversations::CreateService.call(channel: @channel)
    @conversation = conversations_create_service.conversation
    @is_new_conversation = conversations_create_service.is_new_conversation
  end

  def broadcast_append_conversations
    ActionCable.server.broadcast "channel:#{@channel.id}", {
      conversation: ApplicationController.render(partial: 'chat/content/conversations/conversation',
                                                 locals: { conversation: @conversation })
    }
  end

  def broadcast_append_messages
    ActionCable.server.broadcast "channel:#{@channel.id}", {
      sender_message: ApplicationController.render(partial: 'chat/content/conversations/message',
                                                   collection: @form.new_messages,
                                                   as: :message,
                                                   locals: {
                                                     conversation: @conversation,
                                                     is_sender: true,
                                                     channel: @channel,
                                                     message_reaction_form: @message_reaction_form
                                                   }),
      recipient_message: ApplicationController.render(partial: 'chat/content/conversations/message',
                                                      collection: @form.new_messages,
                                                      as: :message,
                                                      locals: {
                                                        conversation: @conversation,
                                                        is_sender: false,
                                                        channel: @channel,
                                                        message_reaction_form: @message_reaction_form
                                                      }),
      sender_id: current_user.id
    }
  end
end
