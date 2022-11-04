# == Schema Information
#
# Table name: messages
#
#  id                                                        :bigint           not null, primary key
#  body                                                      :text
#  is_msg_sent_immediately_after_last_message_from_same_user :boolean          default(FALSE)
#  read_at                                                   :datetime
#  created_at                                                :datetime         not null
#  updated_at                                                :datetime         not null
#  channel_id                                                :bigint           not null
#  conversation_id                                           :bigint
#  user_id                                                   :bigint           not null
#
# Indexes
#
#  index_messages_on_channel_id       (channel_id)
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  belongs_to :conversation
  has_many_attached :attachments, dependent: :destroy

  after_create_commit :set_is_message_sent_immediately_after_last_message_from_the_same_user

  scope :previous_from_the_same_user, ->(id, user_id) {
    where('id < ?', id).where(user_id: user_id).order("id DESC").first || last
  }

  def set_is_message_sent_immediately_after_last_message_from_the_same_user
    message_previous = Message.previous_from_the_same_user(id, user_id)

    return false if message_previous.blank?

    self.is_msg_sent_immediately_after_last_message_from_same_user = message_previous.created_at >= Time.current - 3.minutes
    self.save
  end
end
