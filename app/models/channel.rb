# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id                   :bigint           not null, primary key
#  connected_user_ids   :text
#  last_message_sent_at :datetime
#  name                 :text
#  type                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  creator_id           :bigint
#

# This is your channel model
class Channel < ApplicationRecord
  include Filterable

  self.inheritance_column = :_sti_disabled

  serialize :connected_user_ids, Array

  enum type: { public: 'public', private: 'private', just_two_people: 'just_two_people' }, _suffix: true

  belongs_to :creator, class_name: 'User', optional: true, inverse_of: :admin_channels
  has_one_attached :photo, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :message_notifications, through: :messages
  has_many :joinables, dependent: :destroy
  has_many :joined_users, through: :joinables, source: :user

  accepts_nested_attributes_for :messages

  scope :message_notifications_unread_by_user, ->(ids) { where.not(id: ids) }
  scope :name_cont, lambda { |string|
    where('LOWER(channels.name) LIKE ?', "%#{string.strip.downcase}%")
      .or(where('channels.id IN (
        SELECT c.id
        FROM channels AS c
        LEFT OUTER JOIN joinables AS j ON j.channel_id = c.id
        LEFT OUTER JOIN users AS u ON u.id = j.user_id
        WHERE LOWER(u.name) LIKE ?
      )', "%#{string.strip.downcase}%"))
  }

  def latest_message
    messages.eager_load(:user).order(created_at: :desc).first
  end

  def add_user_to_connected_user_ids!(user_id)
    update!(connected_user_ids: connected_user_ids.push(user_id).uniq)
  end

  def remove_user_to_connected_user_ids!(user_id)
    update!(connected_user_ids: (connected_user_ids - [user_id]).uniq)
  end

  def read_by?(user_id)
    message_notification = message_notifications.unread_by_user(user_id).first
    message_notification.nil?
  end

  def members_except_user(user)
    members = joined_users.includes(avatar_attachment: :blob).where.not(id: user.id)

    if just_two_people_type?
      members.first
    else
      members
    end
  end

  def two_joined_users
    joined_users.includes(avatar_attachment: :blob).order('RANDOM()').limit(2)
  end
end
