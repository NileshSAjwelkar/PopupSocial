FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    description { Faker::Lorem.paragraph }
    username { Faker::Internet.username }
    password { "someRandomPassword" }
    password_confirmation { "someRandomPassword" }
  end
end
