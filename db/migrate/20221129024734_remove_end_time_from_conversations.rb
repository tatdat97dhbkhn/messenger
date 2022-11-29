class RemoveEndTimeFromConversations < ActiveRecord::Migration[7.0]
  def change
    remove_column :conversations, :end_time
  end
end
