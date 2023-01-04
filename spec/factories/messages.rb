FactoryBot.define do
  factory :message, aliases: [:parent] do
    user
    channel
    parent

    body { Faker::Lorem.paragraph }
    is_msg_sent_immediately_after_last_message_from_same_user { true }
    is_start_conversation { true }
    message_reactions_count { 0 }
    type { Message.types.keys.sample }
  end
end
