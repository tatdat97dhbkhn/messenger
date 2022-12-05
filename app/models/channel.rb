# == Schema Information
#
# Table name: channels
#
#  id                   :bigint           not null, primary key
#  connected_user_ids   :text
#  last_message_sent_at :datetime
#  name                 :string
#  type                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Channel < ApplicationRecord
  self.inheritance_column = :_sti_disabled

  serialize :connected_user_ids, Array

  enum type: { public: 'public', private: 'private', just_two_people: 'just_two_people' }, _suffix: true

  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :message_notifications, through: :messages
  has_many :joinables, dependent: :destroy
  has_many :joined_users, through: :joinables, source: :user

  scope :message_notifications_unread_by_user, ->(ids) { where.not(id: ids) }

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

  def add_user_to_connected_user_ids!(user_id)
    update!(connected_user_ids: connected_user_ids.push(user_id).uniq)
  end

  def remove_user_to_connected_user_ids!(user_id)
    update!(connected_user_ids: (connected_user_ids - [user_id]).uniq)
  end

  def is_read_by?(user_id)
    message_notification = message_notifications.unread_by_user(user_id).first
    message_notification.nil?
  end
end
