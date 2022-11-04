# == Schema Information
#
# Table name: channels
#
#  id                   :bigint           not null, primary key
#  last_message_sent_at :datetime
#  name                 :string
#  type                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Channel < ApplicationRecord
  self.inheritance_column = :_sti_disabled

  enum type: { public: 'public', private: 'private', just_two_people: 'just_two_people' }, _suffix: true

  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :joinables, dependent: :destroy
  has_many :joined_users, through: :joinables, source: :user
end
