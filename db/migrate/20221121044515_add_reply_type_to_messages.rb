class AddReplyTypeToMessages < ActiveRecord::Migration[7.0]
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
