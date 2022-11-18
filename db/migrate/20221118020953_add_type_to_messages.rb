class AddTypeToMessages < ActiveRecord::Migration[7.0]
  def up
    add_column :messages, :type, :string
    update_messages_types
  end

  def down
    remove_column :messages, :type
  end

  def update_messages_types
    Message.update(type: Message.types[:plain_text_or_attachment])
  end
end
