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

  class << self
    def find_or_create_just_two_people_channel(users, channel_name)
      channel = Channel.just_two_people_type.find_or_initialize_by(name: channel_name)

      if channel.new_record?
        channel.save

        users.each do |user|
          channel.joinables.create(user_id: user.id)
        end
      end

      channel
    end
  end

  def latest_message
    messages.eager_load(:user).order(created_at: :desc).first
  end
end
