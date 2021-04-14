FactoryBot.define do
  factory :random_merchant, class: Merchant do
    name { Faker::Beer.brand }
  end
end
