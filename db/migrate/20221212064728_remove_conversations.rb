# frozen_string_literal: true

# This is your migration file.
class RemoveConversations < ActiveRecord::Migration[7.0]
  def up
    remove_column :messages, :conversation_id
    drop_table :conversations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
