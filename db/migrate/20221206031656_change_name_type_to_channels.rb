# frozen_string_literal: true

# This is your migration file.
class ChangeNameTypeToChannels < ActiveRecord::Migration[7.0]
  reversible do |dir|
    change_table :channels do |t|
      dir.up do
        t.change :name, :text
      end

      dir.down do
        t.change :name, :string
      end
    end
  end
end
