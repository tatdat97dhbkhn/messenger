# frozen_string_literal: true

class ConversationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(**options)
    ActionCable.server.broadcast "channel:#{options[:channel].id}", {
      conversation: ApplicationController.render(partial: 'chat/channels/conversations/conversation',
                                                 locals: { conversation: options[:conversation] })
    }
  end
end
