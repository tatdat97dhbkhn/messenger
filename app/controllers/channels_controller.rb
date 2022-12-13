class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[show read_message_notifications settings update]
  before_action :set_message_notifications_to_read, only: %i[show read_message_notifications]

  def show
    @message_form = MessageForm.new
    @message_reaction_form = MessageReactionForm.new

    messages = @channel.messages.includes( :channel, :parent, { user: { avatar_attachment: :blob } },
                                           :message_reactions, :attachments_attachments )
                       .order('messages.created_at desc')
    @pagy, messages = pagy_array(messages, items: 20)
    @messages = messages.reverse
  end

  def create
    return if params[:user_ids].blank?

    create_service = Channels::CreateService.call(user_ids: params[:user_ids], current_user: current_user)
    flash.now[:error] = create_service.errors if create_service.fail?
  end

  def update
    @form = ChannelForm.new(params: params, channel: @channel)

    if @form.submit
      body = if params[:type] == 'update_photo'
               "#{current_user.name} changed the channel photo"
             else
               "#{current_user.name} changed the channel name to #{@form.name}"
             end
      Messages::CreateService.call(
        user_id: current_user.id,
        body: body,
        type: Message.types[:notice],
        channel: @channel,
        allow_broadcast_new_message: true
      )

      Channels::UpdateJob.perform_later(channel: @channel, type: params[:type].presence || 'update_name')

      respond_to do |format|
        format.turbo_stream
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        errors = @form.errors.full_messages

        format.turbo_stream { flash.now[:error] = errors }
        format.json { render json: { errors: errors } }
      end
    end
  end

  def read_message_notifications; end

  def settings
    @form = ChannelForm.new(name: @channel.name)
  end

  private

  def set_channel
    @channel =  Channel.find_by(id: params[:id])
  end

  def set_message_notifications_to_read
    MessageNotifications::ReadJob.perform_later(channel: @channel, user_id: current_user.id)
  end
end
