class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[show read_message_notifications]
  before_action :set_message_notifications_to_read, only: %i[show read_message_notifications]

  def show
    @message_form = MessageForm.new
    @message_reaction_form = MessageReactionForm.new

    messages = @channel.messages.includes( :channel, :parent, :user,
                                           :message_reactions, { attachments_attachments: :blob })
                       .order('messages.created_at desc')
    @pagy, messages = pagy_array(messages, items: 20)
    @messages = messages.reverse
  end

  def create
    return if params[:user_ids].blank?

    create_service = Channels::CreateService.call(user_ids: params[:user_ids], current_user: current_user)
    flash.now[:error] = create_service.errors if create_service.fail?
  end

  def read_message_notifications; end

  private

  def set_channel
    @channel =  Channel.find_by(id: params[:id])
  end

  def set_message_notifications_to_read
    MessageNotifications::ReadJob.perform_later(channel: @channel, user_id: current_user.id)
  end
end
