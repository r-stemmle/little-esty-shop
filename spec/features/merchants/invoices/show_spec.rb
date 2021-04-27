require 'rails_helper'

RSpec.describe "Merchant Invoice Show Page" do
  before :each do
    @merchant = create(:random_merchant)
    @item_1 = create(:random_item, merchant: @merchant, unit_price: 100)
    @item_2 = create(:random_item, merchant: @merchant, unit_price: 100)
    @item_3 = create(:random_item, merchant: @merchant, unit_price: 100)
    @bulk_discount_1 = @merchant.discounts.create!(percent: 0.10, quantity: 10)
    @bulk_discount_2 = @merchant.discounts.create!(percent: 0.20, quantity: 20)
    @invoice_1 = create(:random_invoice)
    @invoice_item_1 = create(:random_invoice_item, quantity: 10, unit_price: 100, status: 'pending', item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = create(:random_invoice_item, quantity: 20, unit_price: 100, status: 'pending', item: @item_2, invoice: @invoice_1)
    @invoice_item_3 = create(:random_invoice_item, quantity: 5, unit_price: 100, status: 'pending', item: @item_3, invoice: @invoice_1)
    visit merchant_invoice_path(@merchant, @invoice_1)
  end

  describe "As a visitor, when I visit mechants invoice show page" do
    it "I see information related to that invoice index" do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      within ".customer" do
        expect(page).to have_content(@invoice_1.customer.name)
      end
    end

    it "I see information of the items on the invoice" do
      within ".show-items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(10)
        expect(page).to have_content(20)
        expect(page).to have_content('$100.00')
        expect(page).to have_content('$100.00')
        expect(page).to have_content('pending')
      end
    end

    it "I see total revenue that will be generated from items on invoice" do
      within ".total-revenue" do
        expect(page).to have_content('$3,500.00')
      end
    end

    it "I see a dropdown to update the invoice status" do
      expect(page).to have_button('Update Invoice')
      select "completed", from: 'Status'
      click_on 'Update Invoice'
      expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_1))
      expect(page).to have_content("completed")
    end

    it "I see that the total revenue for my merchant includes bulk discounts in the calculations" do
      within ".total-revenue-with-discounts" do
        expect(page).to have_content('$3,000.00')
      end
    end

    it "Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_link("#{@bulk_discount_1.id}")
      end
      within "#item-#{@item_2.id}" do
        expect(page).to have_link("#{@bulk_discount_2.id}")
      end
      within "#item-#{@item_3.id}" do
        expect(page).to have_content("No Discounts")
      end
    end
  end
end
