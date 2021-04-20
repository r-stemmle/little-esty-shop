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
      item_1 = create(:random_item, id: 1, merchant_id: 22, enabled: true)
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

    it "When I click on the disable button the item is no longer there" do
      merchant = create(:random_merchant, id: 22)
      item_1 = create(:random_item, id: 1, merchant_id: 22, enabled: true)
      item_2 = create(:random_item, id: 2, merchant_id: 22)

      visit merchant_items_path(merchant)

      within '#enabled-items' do
        expect(page).to have_content(item_1.name)
        click_on 'Disable'
        expect(current_path).to eq(merchant_items_path(merchant))
        expect(page).to_not have_content(item_1.name)
      end
    end

    it "When I click on the enable button the item is now enabled" do
      merchant = create(:random_merchant, id: 22)
      item_1 = create(:random_item, id: 1, merchant_id: 22, enabled: true)
      item_2 = create(:random_item, id: 2, merchant_id: 22)

      visit merchant_items_path(merchant)

      within '#disabled-items' do
        click_on 'Enable'
        expect(current_path).to eq(merchant_items_path(merchant))
        expect(page).to_not have_content(item_2.name)
      end
    end

    it "I see the names of the top 5 most popular items, ranked by total revenue generated" do
      merchant = create(:random_merchant, id: 22)
      item_1 = create(:random_item, id: 1, merchant_id: 22)
      item_2 = create(:random_item, id: 2, merchant_id: 22)
      item_3 = create(:random_item, id: 3, merchant_id: 22)
      item_4 = create(:random_item, id: 4, merchant_id: 22)
      item_5 = create(:random_item, id: 5, merchant_id: 22)

      visit merchant_items_path(merchant)

      expect(page).to have_content("Top Items")
      within '#top-items' do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_4.name)
        expect(page).to have_content(item_5.name)

        expect(page).to have_content(item_1.revenue)
        expect(page).to have_content(item_2.revenue)
        expect(page).to have_content(item_3.revenue)
        expect(page).to have_content(item_4.revenue)
        expect(page).to have_content(item_5.revenue)

        expect(page).to have_content(item_1.top_day)
        expect(page).to have_content(item_2.top_day)
        expect(page).to have_content(item_3.top_day)
        expect(page).to have_content(item_4.top_day)
        expect(page).to have_content(item_5.top_day)
        #I was thinking the .top_day method would be for the last user story, and
        #the .revenue method would be used to calculate the item's sales.
        #there are tests for these in the item model spec, if you want to change these names feel free!
      end
    end
  end
end
