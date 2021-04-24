require 'rails_helper'

RSpec.describe "Discount Show Page" do
  describe "As a merchant when i visit my discount show page" do
    it "I see the bulk discounts quantity threshold and percent discount" do
      merchant = create(:random_merchant)
      discount = create(:random_discount)

      visit merchant_discount_path(merchant, discount)

      expect(page).to have_content(merchant.name)
      expect(page).to have_content(discount.id)
      expect(page).to have_content(discount.percent)
      expect(page).to have_content(discount.quantity)
    end
  end
end
