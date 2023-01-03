# frozen_string_literal: true

# This is your migration file.
class AddAttachmentIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :attachment_id, :bigint
  end
end
