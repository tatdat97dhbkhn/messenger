# frozen_string_literal: true

# This is your migration file.
class AddStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :status, :string, null: false, default: 'offline'
  end
end
