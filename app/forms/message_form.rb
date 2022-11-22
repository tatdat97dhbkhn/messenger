class MessageForm < ApplicationForm
  attr_accessor :body, :user_id, :channel_id, :attachments, :params, :message, :messages, :type, :parent_id,
                :reply_type, :attachment_id

  validates :body, presence: true, if: :attachment_blank?

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
          .permit(:body, :user_id, :channel_id, :type, :parent_id, :reply_type, :attachment_id, attachments: [])
  end

  def attachment_blank?
    message_params[:type] == Message.types[:plain_text_or_attachment] &&
      message_params[:attachments].delete_if(&:blank?).blank?
  end
end
