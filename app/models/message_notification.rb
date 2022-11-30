# == Schema Information
#
# Table name: message_notifications
#
#  id         :bigint           not null, primary key
#  read_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_message_notifications_on_message_id  (message_id)
#  index_message_notifications_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (user_id => users.id)
#
class MessageNotification < ApplicationRecord
  belongs_to :message
  belongs_to :user

  scope :unread_by_user, lambda { |user_id|
    where(message_notifications: { user_id: user_id, read_at: [nil, ''] })
      .order('message_notifications.created_at DESC')
  }
end
