# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id                                                        :bigint           not null, primary key
#  body                                                      :text
#  is_msg_sent_immediately_after_last_message_from_same_user :boolean          default(FALSE)
#  is_start_conversation                                     :boolean          default(FALSE)
#  message_reactions_count                                   :integer          default(0), not null
#  type                                                      :string
#  created_at                                                :datetime         not null
#  updated_at                                                :datetime         not null
#  channel_id                                                :bigint           not null
#  parent_id                                                 :bigint
#  user_id                                                   :bigint           not null
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

require 'open-uri'

# This is your message model
class Message < ApplicationRecord
  self.inheritance_column = :_sti_disabled

  attr_accessor :gif_url, :allow_broadcast_new_message

  belongs_to :user
  belongs_to :channel
  belongs_to :parent, class_name: name, optional: true
  has_many :children, class_name: name, foreign_key: 'parent_id', inverse_of: :parent, dependent: :destroy
  has_many :message_reactions, dependent: :destroy
  has_many :message_notifications, dependent: :destroy
  has_many_attached :attachments, dependent: :destroy

  enum type: { icon: 'icon', plain_text_or_attachment: 'plain_text_or_attachment', notice: 'notice' },
       _suffix: true,
       _default: :plain_text_or_attachment

  after_create_commit do
    attach_gif if gif_url.present?
    message_broadcast if allow_broadcast_new_message
    create_message_notifications
    update_channel_last_message_sent_at
  end

  scope :previous_from_the_same_user, lambda { |id, user_id|
    where('id < ?', id).where(user_id:).order('id DESC').first || last
  }

  def message_sent_immediately_after_last_message_from_the_same_user?
    message_previous = channel.messages.order('id DESC').first
    return if message_previous.blank?

    message_previous.user_id == user_id && message_previous.created_at >= 3.minutes.ago &&
      !message_previous.notice_type?
  end

  def attach_gif
    Messages::AttachGifJob.perform_later(message: self, gif_url:)
  end

  private

  def message_broadcast
    MessageBroadcastJob.perform_now(
      channel:,
      messages: [self],
      message_reaction_form: MessageReactionForm.new,
      current_user: Current&.user
    )
  end

  def update_channel_last_message_sent_at
    channel.update(last_message_sent_at: Time.current)

    Channels::UpdateJob.perform_later(
      sender_id: Current&.user&.id,
      channel:,
      message: self,
      type: 'update_latest_message'
    )
  end

  def create_message_notifications
    MessageNotifications::CreateJob.perform_later(not_user_id: user_id, message: self, channel:)
  end
end
