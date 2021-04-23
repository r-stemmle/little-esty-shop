require 'rails_helper'

RSpec.describe "Merchant Discount Delete" do
  describe "When I visit my bulk discounts index" do
    describe "Then next to each bulk discount I see a link to delete it" do
      context "When I click this link" do
        it "I am redirected back to the disounts index page and I no longer see the discount listed" do
          merchant = create(:random_merchant)
          discount = create(:random_discount)
          merchant.discounts << discount
          visit merchant_discounts_path(merchant)

          expect(page).to have_content(discount.id)
          expect(page).to have_link("Delete Discount")
          click_on "Delete Discount"
          expect(current_path).to eq(merchant_discounts_path(merchant))
          expect(page).to_not have_content(discount.id)
          expect(page).to_not have_link("Delete Discount")
        end
      end
    end
  end
end
