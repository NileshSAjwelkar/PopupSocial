FactoryBot.define do
  factory :post do
    user
    title { Faker::Book.title[0..40] }
    content { Faker::Hipster.paragraph }
  end

  trait :content_with_url do
    content { "#{Faker::Hipster.paragraph} . #{Faker::Internet.url} . #{Faker::Internet.url} "}
  end
end
