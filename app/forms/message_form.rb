class MessageForm < ApplicationForm
  attr_accessor :body, :user_id, :channel_id, :attachments, :params, :new_messages, :messages, :type, :parent_id,
                :gif_url, :channel

  validates :body, presence: true, if: :attachment_blank?

  def submit
    assign_attributes(message_params)

    return false if invalid?

    self.new_messages = []
    attachments = message_params[:attachments].delete_if(&:blank?)
    is_child = message_params[:parent_id].present?

    if message_params[:body].present? || (message_params[:body].blank? && attachments.blank?)
      self.new_messages.push(save(message_params.except(:attachments)))
      is_child = false
    end

    if attachments.present?
      attachments.each_with_index do |attachment, index|
        new_message = build_message(message_params.except(:attachments, :body))
        new_message.attachments = [ attachment ]

        if is_child && index.zero?
          new_message.parent_id = message_params[:parent_id]
          is_child = false
        else
          new_message.parent_id = nil
        end

        new_message.save

        self.new_messages.push(new_message)
      end
    end

    true
  end

  private

  def message_params
    params.require(:message_form)
          .permit(:body, :user_id, :channel_id, :type, :parent_id, :gif_url, attachments: [])
  end

  def save(msg_params)
    new_message = build_message(msg_params)
    new_message.save

    new_message
  end

  def build_message(msg_params)
    new_message = messages.build(msg_params)
    new_message.is_msg_sent_immediately_after_last_message_from_same_user =
      new_message.is_message_sent_immediately_after_last_message_from_the_same_user?

    last_message = channel.latest_message
    if last_message.nil? || (last_message.created_at + 30.minutes < Time.current)
      new_message.is_start_conversation = true
    end

    new_message
  end

  def attachment_blank?
    message_params[:type] == Message.types[:plain_text_or_attachment] &&
      (message_params[:attachments].delete_if(&:blank?).blank? && message_params[:gif_url].blank?)
  end
end
