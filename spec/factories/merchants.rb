FactoryBot.define do
  factory :random_merchant, class: Merchant do
    sequence(:name) { |n| "#{Faker::Beer.brand}#{n}" }
    enabled { rand(0..1) }
  end
end
