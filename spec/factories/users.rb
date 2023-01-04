FactoryBot.define do
  factory :user, aliases: [:creator] do
    transient do
      current { Time.current }
    end

    confirmation_sent_at { current }
    confirmation_token { Faker::Config.random.seed }
    confirmed_at { current }
    email { Faker::Internet.email }
    encrypted_password { Faker::Config.random.seed }
    name { Faker::Name.name }
    remember_created_at
    reset_password_sent_at
    reset_password_token
    status { User.statuses.keys.sample }
    unconfirmed_email
  end
end
