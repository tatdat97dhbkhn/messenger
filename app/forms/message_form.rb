class MessageForm < ApplicationForm
  attr_accessor :body, :user_id, :channel_id, :attachments, :params, :message, :messages

  validates :body, presence: true, if: -> { message_params[:attachments].blank? }

  def submit
    assign_attributes(message_params)

    return false if invalid?

    self.message = messages.build(message_params)
    self.message.is_msg_sent_immediately_after_last_message_from_same_user =
      message.is_message_sent_immediately_after_last_message_from_the_same_user?
    message.save
  end

  private

  def message_params
    params.require(:message_form)
          .permit(:body, :user_id, :channel_id, attachments: [])
  end
end
