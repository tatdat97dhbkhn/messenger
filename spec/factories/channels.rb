FactoryBot.define do
  factory :channel, aliases: [:admin_channels] do
    creator

    connected_user_ids
    last_message_sent_at { Time.current }
    name { Faker::Name.name }
    type { Channel.types.keys.sample }
  end
end
