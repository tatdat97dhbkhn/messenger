# frozen_string_literal: true

class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(**options)
    ActionCable.server.broadcast "channel:#{options[:channel].id}", {
      sender_message: ApplicationController.render(partial: 'chat/content/conversations/message',
                                                   collection: options[:form].new_messages,
                                                   as: :message,
                                                   locals: {
                                                     conversation: options[:conversation],
                                                     is_sender: true,
                                                     channel: options[:channel],
                                                     message_reaction_form: options[:message_reaction_form]
                                                   }),
      recipient_message: ApplicationController.render(partial: 'chat/content/conversations/message',
                                                      collection: options[:form].new_messages,
                                                      as: :message,
                                                      locals: {
                                                        conversation: options[:conversation],
                                                        is_sender: false,
                                                        channel: options[:channel],
                                                        message_reaction_form: options[:message_reaction_form]
                                                      }),
      sender_id: options[:current_user].id
    }
  end
end
