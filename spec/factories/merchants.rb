FactoryBot.define do
  factory :merchant do
    name { "MyString" }
  end

  factory :random_merchant, class: Merchant do
    name { Faker::Brand }
  end
end
