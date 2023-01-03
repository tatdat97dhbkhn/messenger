# frozen_string_literal: true

# This is your migration file.
class RemoveAttachmentIdFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :attachment_id, :bigint
  end
end
