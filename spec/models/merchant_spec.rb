require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :items}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "Instance Methods" do
    describe "#ready_to_ship" do
      it "returns items ready to ship" do
        merchant = create(:random_merchant, id: 22)
        item_1 = create(:random_item, id: 1, merchant_id: 22)
        item_2 = create(:random_item, id: 2, merchant_id: 22)
        item_3 = create(:random_item, id: 3, merchant_id: 22)
        invoice_item_1 = create(:random_invoice_item, item: item_1, status: 0)
        invoice_item_2 = create(:random_invoice_item, item: item_2, status: 1)
        invoice_item_3 = create(:random_invoice_item, item: item_3, status: 2)
        expect(merchant.ready_to_ship).to eq([item_1, item_2])
      end
    end
  end

  # describe 'EXAMPLE' do
  #   before {
  #     @merchant_1 = create(:random_merchant)
  #     @merchant_2 = create(:random_merchant)
  #   }

  #   it 'EXAMPLE' do
  #     binding.pry
  #   end
  # end
end
