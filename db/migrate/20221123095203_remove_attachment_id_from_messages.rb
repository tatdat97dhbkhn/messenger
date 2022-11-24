class RemoveAttachmentIdFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :attachment_id
  end
end
