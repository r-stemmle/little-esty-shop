FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { 1 }
    credit_card_expiration_date { "MyString" }
    result { "MyString" }
  end

  factory :random_transation, class: Transation do
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { rand(0..1) }

    association :invoice, factory: :random_invoice
  end
end
