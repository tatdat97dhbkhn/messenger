# frozen_string_literal: true

# This is your migration file.
class AddEndTimeToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :end_time, :datetime
  end
end
