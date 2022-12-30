# frozen_string_literal: true

# This is your migration file.
class AddReplyTypeToMessages < ActiveRecord::Migration[7.0]
  # This is your message class
  class Message < ApplicationRecord
    enum reply_type: {
           not_reply: 'not_reply', video: 'video', audio: 'audio', image: 'image', file: 'file', text: 'text'
         },
         _default: :not_reply
  end

  def up
    add_column :messages, :reply_type, :string
    update_messages_reply_types
  end

  def down
    remove_column :messages, :reply_type
  end

  def update_messages_reply_types
    Message.update(reply_type: Message.reply_types[:not_reply])
  end
end
