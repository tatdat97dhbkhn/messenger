class ChatController < ApplicationController
  def index
    @users = Users::FilterService.call(params: params, users: user_scope)
                                 .users
                                 .order('channels.last_message_sent_at DESC')
                                 .decorate
    @channel_just_two_peoples = Channel.just_two_people_type
  end

  private

  def user_scope
    User.includes(joinables: :channel).confirmed.all_except(current_user.id)
  end
end
