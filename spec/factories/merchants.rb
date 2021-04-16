FactoryBot.define do
  factory :random_merchant, class: Merchant do
    name { Faker::Beer.brand }
    enabled { rand(0..1) }
  end
end
