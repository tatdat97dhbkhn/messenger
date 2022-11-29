module Conversations
  class CreateService < ApplicationService
    parameters :channel
    attr_reader :conversation, :is_new_conversation

    def call
      @conversation = @channel.conversations.order(created_at: :desc).first
      @is_new_conversation = false
      last_message = channel.latest_message

      if last_message.nil? || ( last_message.created_at + 30.minutes < Time.current )
        @conversation = @channel.conversations.create
        @is_new_conversation = true
      end
    end
  end
end
