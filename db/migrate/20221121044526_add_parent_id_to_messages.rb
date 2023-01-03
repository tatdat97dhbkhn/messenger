# frozen_string_literal: true

# This is your migration file.
class AddParentIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :parent_id, :bigint
  end
end
