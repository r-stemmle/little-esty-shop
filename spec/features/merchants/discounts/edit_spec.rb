require 'rails_helper'

RSpec.describe "Bulk Discount Edit" do
  describe "As a merchant when i visit my bulk discount show page" do
    it "Then I see a link to edit the bulk discount" do
      merchant = create(:random_merchant)
      discount = create(:random_discount)
      visit merchant_discount_path(merchant, discount)
      expect(page).to have_link("Edit")
    end

    context "I click the link to the edit form" do
      it "I see that the discounts current attrbs are pre-populated" do
        merchant = create(:random_merchant)
        discount = create(:random_discount)
        visit merchant_discount_path(merchant, discount)
        click_on "Edit"
        expect(current_path).to eq(edit_merchant_discount_path(merchant, discount))
        expect(page).to have_field("Percent", with: "#{discount.percent}")
        expect(page).to have_field("Quantity", with: "#{discount.quantity}")
      end
    end

    describe "When I change discount info and click update" do
      it "I am redirected to the discount show page and its updated" do
        merchant = create(:random_merchant)
        discount = create(:random_discount)
        visit edit_merchant_discount_path(merchant, discount)
        fill_in "Percent", with: 0.05
        fill_in "Quantity", with: 100
        click_on "Update Discount"
        expect(current_path).to eq(merchant_discount_path(merchant, discount))
        expect(page).to have_content(merchant.name)
        expect(page).to have_content(discount.id)
        expect(page).to have_content(0.05)
        expect(page).to have_content(100)
      end
    end

    describe "When I change discount info and click update with blank field" do
      it "I am redirected to the sad path" do
        merchant = create(:random_merchant)
        discount = create(:random_discount)
        visit edit_merchant_discount_path(merchant, discount)
        fill_in "Percent", with: ''
        fill_in "Quantity", with: 100
        click_on "Update Discount"
        expect(current_path).to eq(edit_merchant_discount_path(merchant, discount))
        expect(page).to have_content("Error: Percent can't be blank")
      end
    end
  end
end
