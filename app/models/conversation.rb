# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  end_time   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel_id :bigint           not null
#
# Indexes
#
#  index_conversations_on_channel_id  (channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
class Conversation < ApplicationRecord
  belongs_to :channel
  has_many :messages, dependent: :destroy
end
