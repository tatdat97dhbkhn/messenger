# frozen_string_literal: true

module Channels
  # This is your channels/create service
  class CreateService < ApplicationService
    parameters :user_ids, :current_user
    attr_reader :channel, :users, :is_new_channel

    def call
      ActiveRecord::Base.transaction do
        @users = set_users
        build_channel
        @is_new_channel = channel.new_record?

        if @is_new_channel
          @channel.save!
          create_channel_relations
        end

        Channels::CreateJob.perform_later(channel: @channel, is_new_channel: @is_new_channel, current_user:)
      rescue StandardError => e
        @errors = [e.message]
      end
    end

    private

    def create_channel_relations
      create_message_notice
      create_joinables(users)
    end

    def build_channel
      channel_name = generate_channel_name

      if just_two_people_channel?
        @channel = Channel.just_two_people_type.find_or_initialize_by(name: channel_name)
      else
        @channel = Channel.private_type.new
        @channel.name = channel_name
        @channel.creator_id = current_user.id
      end
    end

    def create_joinables(users)
      users.each do |user|
        channel.joinables.create!(user_id: user.id)
      end
    end

    def set_users
      User.where(id: ([current_user.id] + user_ids))
    end

    def just_two_people_channel?
      user_ids.size < 2
    end

    def generate_channel_name
      if just_two_people_channel?
        arr_user_ids = [user_ids.first.to_i, current_user.id].sort
        "just_two_people_#{arr_user_ids[0]}_#{arr_user_ids[1]}"
      else
        user_names = users.pluck(:name)
        user_names.join(', ')
      end
    end

    def create_message_notice
      body = if channel.private_type?
               "#{current_user.name} created a channel"
             else
               'Became friends, can now text each other'
             end

      messages_create_service = Messages::CreateService.call(
        user_id: current_user.id,
        body:,
        type: Message.types[:notice],
        channel:,
        allow_broadcast_new_message: false
      )

      raise ActiveRecord::Rollback if messages_create_service.fail?
    end
  end
end
