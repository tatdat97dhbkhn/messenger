class AddMessageReactionsCountToMessages < ActiveRecord::Migration[7.0]
  def self.up
    add_column :messages, :message_reactions_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :messages, :message_reactions_count
  end
end
