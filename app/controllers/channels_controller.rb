class ChannelsController < ApplicationController
  include ChannelsHelper

  before_action :set_friend, only: :show_or_create

  def show_or_create
    channel_name = generate_just_two_people_channel_name(@friend, current_user)
    @channel = Channel.find_or_create_just_two_people_channel([@friend, current_user], channel_name)

    @message_form = MessageForm.new
    @message_reaction_form = MessageReactionForm.new

    conversations = @channel.conversations
                            .includes(messages: [
                              :parent, :user, :message_reactions,
                              { attachments_attachments: :blob }
                            ])
                            .order('conversations.created_at desc', 'messages.created_at asc')
    @pagy, conversations = pagy_array(conversations, items: 10)
    @conversations = conversations.reverse
  end

  private

  def set_friend
    @friend = User.find_by(id: params[:friend_id])
  end
end
