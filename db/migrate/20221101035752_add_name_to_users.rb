# frozen_string_literal: true

# This is your migration file.
class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false, default: 'name'
  end
end
