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
    if message.attachments.blank?
      reply_content = message.body

      if reply_content.blank?
        reply_content = "#{render(partial: 'chat/channels/messages/message_reply/like_button')}"
      else
        reply_content = "<p class='break-all'>#{reply_content}</p>"
      end
    else
      reply_content = "#{render(partial: 'chat/channels/messages/message_reply/attachment',
                                locals: {
                                  attachment: message.attachments.first
                                })}"
    end

    reply_content
  end
end
