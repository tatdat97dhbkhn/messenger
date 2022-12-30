# frozen_string_literal: true

# This is your migration file.
class CreateMessageReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :message_reactions do |t|
      t.references :message, null: false, foreign_key: true
      t.string :type, null: false

      t.timestamps
    end
  end
end
