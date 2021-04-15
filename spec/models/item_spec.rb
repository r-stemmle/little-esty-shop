require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many :invoice_items}
    it {should belong_to :merchant}
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_numericality_of :unit_price}
  end

  describe "class methods" do
    describe ".not_shipped" do
      it "returns items that haven't been shipped" do
        item_1 = create(:random_item, id: 1)
        item_2 = create(:random_item, id: 2)
        item_3 = create(:random_item, id: 3)
        invoice_item_1 = create(:random_invoice_item, item: item_1, status: 0)
        invoice_item_2 = create(:random_invoice_item, item: item_2, status: 1)
        invoice_item_3 = create(:random_invoice_item, item: item_3, status: 2)

        expect(Item.not_shipped).to eq([item_1, item_2])

      end
    end
  end
end
