FactoryBot.define do
  factory :current do
    transient do
      user
    end
  end
end
