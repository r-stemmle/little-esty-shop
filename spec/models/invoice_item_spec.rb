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
    describe ".items_ready_to_ship" do
      it "returns invoice_ids of items not shipped" do
        merchant = create(:random_merchant, id: 22)
        item_1 = create(:random_item, id: 1, merchant_id: 22)
        item_2 = create(:random_item, id: 2, merchant_id: 22)
        item_3 = create(:random_item, id: 3, merchant_id: 22)
        invoice_item_1 = create(:random_invoice_item, item: item_1, status: 0)
        invoice_item_2 = create(:random_invoice_item, item: item_2, status: 1)
        invoice_item_3 = create(:random_invoice_item, item: item_3, status: 2)
        expect(InvoiceItem.items_ready_to_ship(merchant).count).to eq(2)
      end
    end
  end
end
