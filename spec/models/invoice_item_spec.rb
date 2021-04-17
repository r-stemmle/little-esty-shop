require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe "validations" do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
  end

  describe "class methods" do
    it '.highest_revenue_merchant_ids' do
      item_1 = create(:random_item)
      item_2 = create(:random_item)
      item_3 = create(:random_item)
      item_4 = create(:random_item)
      item_5 = create(:random_item)
      item_6 = create(:random_item)
      item_7 = create(:random_item)

      invoice_1 = create(:random_invoice)
      invoice_2 = create(:random_invoice)
      invoice_3 = create(:random_invoice)
      invoice_4 = create(:random_invoice)
      invoice_5 = create(:random_invoice)
      invoice_6 = create(:random_invoice)
      invoice_7 = create(:random_invoice)

      invoice_item_1 = create(:random_invoice_item, invoice: invoice_1, item: item_1, unit_price: 1, quantity: 1)
      invoice_item_2 = create(:random_invoice_item, invoice: invoice_2, item: item_2, unit_price: 2, quantity: 1)
      invoice_item_3 = create(:random_invoice_item, invoice: invoice_3, item: item_3, unit_price: 3, quantity: 1)
      invoice_item_4 = create(:random_invoice_item, invoice: invoice_4, item: item_4, unit_price: 4, quantity: 1)
      invoice_item_5 = create(:random_invoice_item, invoice: invoice_5, item: item_5, unit_price: 5, quantity: 1)
      invoice_item_6 = create(:random_invoice_item, invoice: invoice_6, item: item_6, unit_price: 6, quantity: 1)
      invoice_item_7 = create(:random_invoice_item, invoice: invoice_7, item: item_7, unit_price: 0, quantity: 1)

      transaction_1 = create(:random_transaction, result: 1, invoice: invoice_1)
      transaction_2 = create(:random_transaction, result: 1, invoice: invoice_2)
      transaction_3 = create(:random_transaction, result: 1, invoice: invoice_3)
      transaction_4 = create(:random_transaction, result: 1, invoice: invoice_4)
      transaction_5 = create(:random_transaction, result: 1, invoice: invoice_5)
      transaction_6 = create(:random_transaction, result: 0, invoice: invoice_6)
      transaction_7 = create(:random_transaction, result: 1, invoice: invoice_7)

      expect(InvoiceItem.highest_revenue_merchant_ids.first.revenue).to eq(5)
      expect(InvoiceItem.highest_revenue_merchant_ids.last.revenue).to eq(1)
    end
  end
end
