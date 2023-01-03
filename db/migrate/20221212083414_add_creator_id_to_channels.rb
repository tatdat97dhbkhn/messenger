# frozen_string_literal: true

# This is your migration file.
class AddCreatorIdToChannels < ActiveRecord::Migration[7.0]
  class Joinable < ApplicationRecord
    belongs_to :user, class_name: 'AddCreatorIdToChannels::User'
    belongs_to :channel, class_name: 'AddCreatorIdToChannels::Channel'
  end

  class User < ApplicationRecord
    has_many :joinables, class_name: 'AddCreatorIdToChannels::Joinable', dependent: :destroy
    has_many :joined_channels, through: :joinables, source: :channel
  end

  class Channel < ApplicationRecord
    self.inheritance_column = :_sti_disabled

    enum type: { public: 'public', private: 'private', just_two_people: 'just_two_people' }, _suffix: true

    has_many :joinables, class_name: 'AddCreatorIdToChannels::Joinable', dependent: :destroy
    has_many :joined_users, through: :joinables, source: :user
  end

  def up
    add_column :channels, :creator_id, :bigint
    update_channels_creator_ids
  end

  def down
    remove_column :channels, :creator_id
  end

  def update_channels_creator_ids
    ActiveRecord::Base.transaction do
      Channel.private_type.find_each do |channel|
        first_user = channel.joined_users.first

        channel.update!(creator_id: first_user.id)
      end
    end
  end
end
# rubocop:enable Style/Documentation
