module Conversations
  class CreateService < ApplicationService
    parameters :channel
    attr_reader :conversation, :is_new_conversation

    def call
      @conversation = @channel.conversations.order(created_at: :desc).first
      @is_new_conversation = false

      return unless @conversation.nil? || Time.current > @conversation.end_time

      @conversation = @channel.conversations.create(end_time: Time.current + 30.minutes)
      @is_new_conversation = true
    end
  end
end
