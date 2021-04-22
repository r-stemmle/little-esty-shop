FactoryBot.define do
  factory :random_discount, class: Discount do
    percent { Faker::Number.between(from: 0.0, to: 1.0) }
    quantity { Faker::Number.number(digits: 2) }
    association :merchant, factory: :random_merchant
  end
end
