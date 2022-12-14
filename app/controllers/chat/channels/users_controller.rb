# frozen_string_literal: true

module Chat
  module Channels
    # This is your chat/channels/users controller
    class UsersController < ApplicationController
      before_action :set_channel, only: %i[joined_users not_joined_users add kick leave]
      before_action :set_user, only: %i[add kick leave]

      def joined_users
        @users = Users::FilterService.call(params:, users: user_scope)
                                     .users
      end

      def not_joined_users
        @users = Users::FilterService.call(params:, users: not_joined_user_scope)
                                     .users
      end

      def add
        add_service = ::Channels::Users::AddService.call(user: @user, current_user:, channel: @channel)
        flash.now[:error] = add_service.errors if add_service.fail?
      end

      def kick
        kick_service = ::Channels::Users::KickService.call(user: @user, current_user:, channel: @channel)
        flash.now[:error] = kick_service.errors if kick_service.fail?
      end

      def leave
        leave_service = ::Channels::Users::LeaveService.call(current_user:, channel: @channel)
        flash.now[:error] = leave_service.errors if leave_service.fail?
      end

      private

      def set_user
        @user = User.find_by(id: params[:id])
      end

      def not_joined_user_scope
        User.where.not(id: @channel.joined_users.ids).includes(avatar_attachment: :blob)
      end

      def user_scope
        @channel.joined_users.includes(avatar_attachment: :blob)
      end

      def set_channel
        @channel = Channel.find_by(id: params[:channel_id])
      end
    end
  end
end
