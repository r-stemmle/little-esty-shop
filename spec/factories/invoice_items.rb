FactoryBot.define do
  factory :random_invoice_item, class: InvoiceItem do
    quantity { rand(1..10) }
    status { rand(0..2) }
    unit_price { Faker::Number.number(digits: 5) }

    association :item, factory: :random_item
    association :invoice, factory: :random_invoice
  end
end
