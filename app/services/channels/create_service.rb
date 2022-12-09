module Channels
  class CreateService < ApplicationService
    parameters :user_ids, :current_user
    attr_reader :channel, :users, :is_new_channel

    def call
      ActiveRecord::Base.transaction do
        channel_name = generate_channel_name

        if is_just_two_people_channel?
          @channel = Channel.just_two_people_type.find_or_initialize_by(name: channel_name)
        else
          @channel = Channel.private_type.new
          @channel.name = channel_name
        end

        @is_new_channel = channel.new_record?

        if @is_new_channel
          @channel.save!
          create_message_notice
          create_joinables(set_users)
        end

        Channels::CreateJob.perform_later(channel: @channel, is_new_channel: @is_new_channel, current_user: current_user)
      rescue => e
        @errors = [ e.message ]
      end
    end

    private

    def create_joinables(users)
      users.each do |user|
        @errors.push(@channel.errors.full_messages) unless channel.joinables.create!(user_id: user.id)
      end
    end

    def set_users
      @users ||= User.where(id: ([current_user.id] + user_ids))
    end

    def is_just_two_people_channel?
      user_ids.size < 2
    end

    def generate_channel_name
      if is_just_two_people_channel?
        arr_user_ids = [user_ids.first.to_i, current_user.id].sort
        "just_two_people_#{arr_user_ids[0]}_#{arr_user_ids[1]}"
      else
        user_names = set_users.pluck(:name)
        user_names.join(', ')
      end
    end

    def create_message_notice
      body = channel.private_type? ? "#{current_user.name} created a channel" : 'Became friends, can now text each other'

      channel.messages.create!({
        user_id: current_user.id,
        body: body,
        type: Message.types[:notice],
        conversation_attributes: {
          channel_id: channel.id
        }
      })
    end
  end
end
