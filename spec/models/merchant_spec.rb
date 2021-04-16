require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :items}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
    context 'enabled and disabled' do
      before do
        @merchant_1 = create(:random_merchant, enabled: true)
        @merchant_2 = create(:random_merchant, enabled: false)
      end
      
      it '.all_enabled' do
        expect(Merchant.all_enabled).to eq([@merchant_1])
      end
  
      it '.all_disabled' do
        expect(Merchant.all_disabled).to eq([@merchant_2])
      end
    end

    it '.top_merchant' do
      merchant_1 = create(:random_merchant)
      merchant_2 = create(:random_merchant)
      merchant_3 = create(:random_merchant)
      merchant_4 = create(:random_merchant)
      merchant_5 = create(:random_merchant)
      merchant_6 = create(:random_merchant)

      item_1 = create(:random_item, merchant: merchant_1)
      item_2 = create(:random_item, merchant: merchant_2)
      item_3 = create(:random_item, merchant: merchant_3)
      item_4 = create(:random_item, merchant: merchant_4)
      item_5 = create(:random_item, merchant: merchant_5)
      item_6 = create(:random_item, merchant: merchant_6)

      invoice_1 = create(:random_invoice)
      invoice_2 = create(:random_invoice)
      invoice_3 = create(:random_invoice)
      invoice_4 = create(:random_invoice)
      invoice_5 = create(:random_invoice)
      invoice_6 = create(:random_invoice)

      invoice_item_1 = create(:random_invoice_item, invoice: invoice_1, item: item_1, unit_price: 1, quantity: 1)
      invoice_item_2 = create(:random_invoice_item, invoice: invoice_2, item: item_2, unit_price: 2, quantity: 1)
      invoice_item_3 = create(:random_invoice_item, invoice: invoice_3, item: item_3, unit_price: 3, quantity: 1)
      invoice_item_4 = create(:random_invoice_item, invoice: invoice_4, item: item_4, unit_price: 4, quantity: 1)
      invoice_item_5 = create(:random_invoice_item, invoice: invoice_5, item: item_5, unit_price: 5, quantity: 1)
      invoice_item_6 = create(:random_invoice_item, invoice: invoice_6, item: item_6, unit_price: 6, quantity: 1)

      transaction_1 = create(:random_transaction, result: 1, invoice: invoice_1)
      transaction_2 = create(:random_transaction, result: 1, invoice: invoice_2)
      transaction_3 = create(:random_transaction, result: 1, invoice: invoice_3)
      transaction_4 = create(:random_transaction, result: 1, invoice: invoice_4)
      transaction_5 = create(:random_transaction, result: 1, invoice: invoice_5)
      transaction_6 = create(:random_transaction, result: 0, invoice: invoice_6)
binding.pry
      expect(Merchant.top_merchants).to eq([merchant_5, merchant_4, merchant_3, merchant_2, merchant_1])
    end
  end
end
