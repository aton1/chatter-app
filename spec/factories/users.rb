FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 2..25) }
    password { Faker::Internet.password }
    description { Faker::Lorem.paragraph_by_chars(number: 230, supplemental: false) }
  end
end
