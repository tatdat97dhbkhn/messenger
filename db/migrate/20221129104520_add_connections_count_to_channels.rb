# frozen_string_literal: true

# This is your migration file.
class AddConnectionsCountToChannels < ActiveRecord::Migration[7.0]
  def change
    add_column :channels, :connected_user_ids, :text
  end
end
