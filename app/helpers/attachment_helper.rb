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

  def reply_content_mapping_reply_type(attachment, message)
    if attachment.nil?
      reply_content = message.body
      reply_content = 'like' if reply_content.blank?
    else
      reply_content = reply_type_mapping_attachment(attachment)
    end

    reply_content
  end
end
