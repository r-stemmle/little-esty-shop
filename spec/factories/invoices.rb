FactoryBot.define do
  factory :invoice do
    customer { nil }
    status { 1 }
  end

  factory :random_invoice, class: Invoice do
    status { rand(0..2) }

    association :customer, factory: :random_customer
  end
end
