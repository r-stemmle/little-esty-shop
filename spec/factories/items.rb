FactoryBot.define do
  factory :random_item, class: Item do
    sequence(:name) { |n| "#{Faker::Beer.name}#{n}" }
    description { Faker::Lorem.sentence(word_count: 3) }
    unit_price { Faker::Number.number(digits: 5) }
    association :merchant, factory: :random_merchant
  end
end
