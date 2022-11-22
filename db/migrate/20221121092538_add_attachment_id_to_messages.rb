class AddAttachmentIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :attachment_id, :bigint
  end
end
