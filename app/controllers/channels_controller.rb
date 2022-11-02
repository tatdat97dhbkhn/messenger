class ChannelsController < ApplicationController
  include ChannelsHelper

  before_action :set_friend, only: :show_or_create

  def show_or_create
    channel_name = generate_just_two_people_channel_name(@friend, current_user)
    @channel = Channel.just_two_people_type.find_or_create_by(name: channel_name)
  end

  private

  def set_friend
    @friend = User.find_by(id: params[:friend_id])
  end
end
