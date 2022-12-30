# frozen_string_literal: true

# This is your attachment helper
module AttachmentHelper
  def reply_type_mapping_attachment(attachment)
    if attachment.image?
      'image'
    elsif attachment.video?
      'video'
    elsif attachment.audio?
      'audio'
    else
      'file'
    end
  end

  def reply_content_mapping_reply_type(message)
    if message.gif_url.present?
      gif_reply_content(message)
    elsif message.attachments.blank?
      without_attachment_reply_content(message)
    else
      attachment_reply_content(message)
    end
  end

  def gif_reply_content(message)
    # rubocop:disable Style/RedundantInterpolation
    "#{render(partial: 'chat/channels/messages/message_reply/gif',
              locals: {
                gif_url: message.gif_url
              })}"
    # rubocop:enable Style/RedundantInterpolation
  end

  def attachment_reply_content(message)
    # rubocop:disable Style/RedundantInterpolation
    "#{render(partial: 'chat/channels/messages/message_reply/attachment',
              locals: {
                attachment: message.attachments.first
              })}"
    # rubocop:enable Style/RedundantInterpolation
  end

  def without_attachment_reply_content(message)
    reply_content = message.body

    if reply_content.blank?
      # rubocop:disable Style/RedundantInterpolation
      "#{render(partial: 'chat/channels/messages/message_reply/like_button')}"
      # rubocop:enable Style/RedundantInterpolation
    else
      "<p class='break-all'>#{reply_content}</p>"
    end
  end
end
