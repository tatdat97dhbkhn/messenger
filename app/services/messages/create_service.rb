# frozen_string_literal: true

module Messages
  # This is your messages/create service
  class CreateService < ApplicationService
    parameters :user_id, :channel, :body, :type, :allow_broadcast_new_message
    attr_reader :message

    def call
      ActiveRecord::Base.transaction do
        @message = channel.messages.create!({
                                              user_id:,
                                              body:,
                                              type:,
                                              allow_broadcast_new_message:
                                            })
      rescue StandardError => e
        @errors = [e.message]
      end
    end
  end
end
