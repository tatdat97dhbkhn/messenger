class ChannelDecorator < ApplicationDecorator
  def latest_message
    object.latest_message
  end

  def last_message_body(sender)
    return if latest_message.nil?

    attachment = latest_message.attachments.last

    if attachment.nil?
      latest_message.body
    else
      "#{sender.name} send a #{attachment_type(attachment)}"
    end
  end

  def attachment_type(attachment)
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
end
