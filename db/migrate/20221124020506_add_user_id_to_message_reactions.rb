class AddUserIdToMessageReactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :message_reactions, :user, foreign_key: true
  end
end
