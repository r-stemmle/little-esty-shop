FactoryBot.define do
  factory :customer do
    first_name { "MyString" }
    last_name { "MyString" }
  end

  factory :random_customer, class: Customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
