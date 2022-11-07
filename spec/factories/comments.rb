FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    
    trait :for_post do
      association :commentable, factory: :post
    end
    
    # trait :for_comment do
      
    # end
  end
end
