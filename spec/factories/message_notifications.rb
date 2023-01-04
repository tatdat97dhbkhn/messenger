FactoryBot.define do
  factory :message_notification do
    user
    message

    read_at { Time.current }
  end
end
