class AddColumnToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :is_msg_sent_immediately_after_last_message_from_same_user, :boolean, default: false
  end
end
