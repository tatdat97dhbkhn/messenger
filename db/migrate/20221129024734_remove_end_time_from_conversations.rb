# frozen_string_literal: true

# This is your migration file.
class RemoveEndTimeFromConversations < ActiveRecord::Migration[7.0]
  def change
    remove_column :conversations, :end_time, :datetime
  end
end
