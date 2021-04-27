require 'rails_helper'

RSpec.describe Discount, type: :model do
  it {should belong_to :merchant}
  it {should have_many :items}

  describe "class methods" do
    describe ".find_by_min_ordered" do
      it "returns one discount by quantity from invoice_item" do
        discount_1 = create(:random_discount, quantity: 5)
        discount_2 = create(:random_discount, quantity: 10)
        discount_3 = create(:random_discount, quantity: 15)
        expect(Discount.find_by_min_ordered(12)).to eq(discount_2)
      end
    end
  end
end
