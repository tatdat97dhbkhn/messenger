# == Schema Information
#
# Table name: message_reactions
#
#  id         :bigint           not null, primary key
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  user_id    :bigint
#
# Indexes
#
#  index_message_reactions_on_message_id  (message_id)
#  index_message_reactions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (user_id => users.id)
#
class MessageReaction < ApplicationRecord
  self.inheritance_column = :_sti_disabled

  belongs_to :message
  belongs_to :user

  enum type: { angry: 'angry', care: 'care', haha: 'haha', like: 'like', love: 'love', sad: 'sad', wow: 'wow' },
       _suffix: true,
       _default: :like

  after_commit :broadcast_to_message_channel

  def broadcast_to_message_channel
    broadcast_replace_to(message,
                         target: "message-#{message.id}-reactions",
                         partial: 'chat/content/conversations/message_actions/reacted',
                         locals: {
                           message: message
                         })
  end
end
