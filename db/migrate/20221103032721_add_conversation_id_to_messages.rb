# frozen_string_literal: true

# This is your migration file.
class AddConversationIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :conversation, foreign_key: true
  end
end
