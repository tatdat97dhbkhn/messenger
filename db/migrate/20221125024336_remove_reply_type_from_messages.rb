# frozen_string_literal: true

# This is your migration file.
class RemoveReplyTypeFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :reply_type, :string
  end
end
