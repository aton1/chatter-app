FactoryBot.define do
  factory :message do
    body { Faker::Hipster.sentence }
    user { create(:user) }
  end
end
