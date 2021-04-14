FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { 1 }
    merchant { nil }
  end

  factory :random_item, class: Item do
    name { Faker::Beer.name }
    description { Faker::Lorem.sentence(word_count: 3) }
    unit_price { Faker::Number.number(digits: 5) }
    association :merchant, factory: :random_merchant
  end
end
