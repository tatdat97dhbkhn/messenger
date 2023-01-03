# frozen_string_literal: true

# This is your migration file.
class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.datetime :last_message_sent_at
      t.string :type, null: false

      t.timestamps
    end
  end
end
