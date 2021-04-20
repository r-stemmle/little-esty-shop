require 'rails_helper'

# Merchant Items Index Page
#
# As a merchant,
# When I visit my merchant items index page ("merchant/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant

RSpec.describe "Merchant Items Index Page" do
  context "I visit the items index page" do
    it "I see a list of the names of all my items they are links to the items show page" do
      merchant = create(:random_merchant, id: 22)
      merchant_2 = create(:random_merchant, id: 21)
      item_1 = create(:random_item, id: 1, merchant_id: 22)
      item_2 = create(:random_item, id: 2, merchant_id: 22)
      item_3 = create(:random_item, id: 3, merchant_id: 22)
      item_4 = create(:random_item, id: 4, merchant_id: 22)
      item_5 = create(:random_item, id: 5, merchant_id: 22)
      item_6 = create(:random_item, id: 6, merchant_id: 22)
      item_7 = create(:random_item, id: 7, merchant_id: 21)

      visit merchant_items_path(merchant)
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_4.name)
      expect(page).to have_content(item_5.name)
      expect(page).to have_content(item_6.name)
      expect(page).to have_link(item_1.name)
      expect(page).to have_link(item_2.name)
      expect(page).to have_link(item_3.name)
      expect(page).to_not have_content(item_7.name)
    end

    it "I see a button to enable or disable each item" do
      merchant = create(:random_merchant, id: 22)
      item_1 = create(:random_item, id: 1, merchant_id: 22)
      item_2 = create(:random_item, id: 2, merchant_id: 22)

      visit merchant_items_path(merchant)

      within '#enabled-items' do
        expect(page).to have_content(item_1.name)
        expect(page).to_not have_content(item_2.name)
        expect(page).to have_button('Disable')
      end

      within '#disabled-items' do
        expect(page).to_not have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_button('Enable')
      end
    end
  end
end
