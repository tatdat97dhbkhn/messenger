class CreateMessageNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :message_notifications do |t|
      t.references :message, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :read_at

      t.timestamps
    end
  end
end
