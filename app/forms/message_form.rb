class MessageForm < ApplicationForm
  attr_accessor :body, :user_id, :channel_id, :attachments, :params, :message, :messages

  validates :body, presence: true
  # validate :validate_attachment_filetypes

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

  # def validate_attachment_filetypes
  #   return unless attachments.attached?
  #
  #   attachments.each do |attachment|
  #     unless attachment.content_type.in?(%w[image/jpeg image/png image/gif video/mp4 video/mpeg audio/x-wav audio/ogg
  #                                             audio/vnd.wave audio/webm audio/mp3])
  #       errors.add(:attachments, 'must be a JPEG, PNG, GIF, MP4, MP3, OGG, or WAV file')
  #     end
  #   end
  # end
end
