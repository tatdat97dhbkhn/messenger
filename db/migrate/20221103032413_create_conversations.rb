# frozen_string_literal: true

# This is your migration file.
class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
