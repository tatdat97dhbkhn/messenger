# frozen_string_literal: true

# This is your message_broadcast job
class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(**options)
    ActionCable.server.broadcast "channel:#{options[:channel].id}", {
      sender_message: sender_message(**options),
      recipient_message: recipient_message(**options),
      sender_id: options[:current_user].id
    }
  end

  private

  def sender_message(**options)
    ApplicationController.render(partial: 'chat/channels/messages/message',
                                 collection: options[:messages],
                                 as: :message,
                                 locals: {
                                   is_sender: true,
                                   channel: options[:channel],
                                   message_reaction_form: options[:message_reaction_form]
                                 })
  end

  def recipient_message(**options)
    ApplicationController.render(partial: 'chat/channels/messages/message',
                                 collection: options[:messages],
                                 as: :message,
                                 locals: {
                                   is_sender: false,
                                   channel: options[:channel],
                                   message_reaction_form: options[:message_reaction_form]
                                 })
  end
end
