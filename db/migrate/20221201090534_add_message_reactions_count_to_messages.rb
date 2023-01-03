# frozen_string_literal: true

# This is your migration file.
class AddMessageReactionsCountToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :message_reactions_count, :integer, null: false, default: 0
  end
end
