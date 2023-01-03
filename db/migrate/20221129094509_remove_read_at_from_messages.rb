# frozen_string_literal: true

# This is your migration file.
class RemoveReadAtFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :read_at, :datetime
  end
end
