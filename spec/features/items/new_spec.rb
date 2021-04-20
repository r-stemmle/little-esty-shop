require 'rails_helper'

RSpec.describe "Merchant New Item" do
  before :each do
    @merchant = create(:random_merchant, id: 22)
  end

  describe "When I visit my items index page" do
    it "I see a link to create a new item" do
      visit merchant_items_path(@merchant)

      expect(page).to have_link("New item")
    end

    context "And then I click on the link" do
      it "I am taken to a form that allows me to add new item information" do
        visit new_merchant_item_path(@merchant)

        fill_in "Name", with: "new name"
        fill_in "Description", with: "description"
        fill_in "Unit price", with: 3

        click_on "Create Item"


        expect(current_path).to eq(merchant_items_path(@merchant))
        within "#disabled-items" do
          expect(page).to have_content("new name")
        end
      end
    end
  end
end
