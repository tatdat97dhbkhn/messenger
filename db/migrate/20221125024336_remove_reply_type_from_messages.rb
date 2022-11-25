class RemoveReplyTypeFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :reply_type
  end
end
