class ChannelsController < ApplicationController
  include ChannelsHelper

  before_action :set_friend, only: :show_or_create
  before_action :set_channel, only: %i[show_or_create read_message_notifications]
  before_action :set_message_notifications_to_read, only: %i[show_or_create read_message_notifications]

  def show_or_create
    @message_form = MessageForm.new
    @message_reaction_form = MessageReactionForm.new

    conversations = @channel.conversations
                            .includes(messages: [
                              :channel, :parent, :user, :message_reactions, :message_notifications,
                              { attachments_attachments: :blob }
                            ])
                            .order('conversations.created_at desc', 'messages.created_at asc')
    @pagy, conversations = pagy_array(conversations, items: 10)
    @conversations = conversations.reverse
  end

  def read_message_notifications; end

  private

  def set_friend
    @friend = User.find_by(id: params[:friend_id])
  end

  def set_channel
    @channel = if params[:id].present?
      Channel.find_by(id: params[:id])
    else
      channel_name = generate_just_two_people_channel_name(@friend, current_user)
      Channel.find_or_create_just_two_people_channel([@friend, current_user], channel_name)
    end
  end

  def set_message_notifications_to_read
    MessageNotifications::ReadJob.perform_later(channel: @channel, user_id: current_user.id)
  end
end
