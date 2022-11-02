# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  body       :text
#  read_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_channel_id  (channel_id)
#  index_messages_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  has_many_attached :attachments, dependent: :destroy
end
