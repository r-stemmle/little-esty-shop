require 'rails_helper'

RSpec.describe "Merchant Bulk Discount Create" do
  describe "As a merchant when I visit my discounts index page" do
    it "I see a link to create a new discount" do
      merchant = create(:random_merchant)

      visit merchant_discounts_path(merchant)
      expect(page).to have_link("Create Discount")
    end

    it "I click this link and Im taken to the form to add discount" do
      merchant = create(:random_merchant)

      visit merchant_discounts_path(merchant)
      click_on "Create Discount"
      expect(current_path).to eq(new_merchant_discount_path(merchant))
      fill_in "Percent", with: 0.7
      fill_in "Quantity", with: 70
      click_on "Create Discount"
      expect(current_path).to eq(merchant_discounts_path(merchant))
      expect(page).to have_content('70%')
      expect(page).to have_content('70')
      # save_and_open_page
    end
  end


end
