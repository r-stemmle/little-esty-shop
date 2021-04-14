FactoryBot.define do
  factory :random_invoice, class: Invoice do
    status { rand(0..2) }

    association :customer, factory: :random_customer
  end
end
