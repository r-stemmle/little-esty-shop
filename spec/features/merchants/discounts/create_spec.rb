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
      save_and_open_page
    end
  end

# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed
end
