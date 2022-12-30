# frozen_string_literal: true

# == Schema Information
#
# Table name: joinables
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_joinables_on_channel_id  (channel_id)
#  index_joinables_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (user_id => users.id)
#

# This is your joinable model
class Joinable < ApplicationRecord
  belongs_to :user
  belongs_to :channel
end
