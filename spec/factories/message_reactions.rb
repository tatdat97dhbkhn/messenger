FactoryBot.define do
  factory :message_reaction do
    user
    message

    type { MessageReaction.types.keys.sample }
  end
end
