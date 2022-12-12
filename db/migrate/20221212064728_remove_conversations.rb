class RemoveConversations < ActiveRecord::Migration[7.0]
  def up
    remove_column :messages, :conversation_id
    drop_table :conversations
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
