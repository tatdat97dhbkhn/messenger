class ChatController < ApplicationController
  def index
    @users = Users::FilterService.call(params: params, users: user_scope).users.decorate
  end

  private

  def user_scope
    User.confirmed.all_except(current_user.id)
  end
end
