class AddIsStartConversationToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :is_start_conversation, :boolean, default: false
  end
end
