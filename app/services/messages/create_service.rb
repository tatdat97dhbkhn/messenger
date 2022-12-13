module Messages
  class CreateService < ApplicationService
    parameters :user_id, :channel, :body, :type, :allow_broadcast_new_message
    attr_reader :message

    def call
      ActiveRecord::Base.transaction do
        @message = channel.messages.create!({
                                   user_id: user_id,
                                   body: body,
                                   type: type,
                                   allow_broadcast_new_message: allow_broadcast_new_message
                                 })
      rescue => e
        @errors = [ e.message ]
      end
    end
  end
end
