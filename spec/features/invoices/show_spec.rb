require 'rails_helper'

RSpec.describe "Merchant Invoice Show Page" do
  describe "As a visitor (/merchants/merchant_id/invoices/invoice_id)" do
    it "I see information related to that invoice index" do
      merchant = create(:random_merchant)
      item_1 = create(:random_item, merchant: merchant)
      invoice_1 = create(:random_invoice)
      invoice_item_1 = create(:random_invoice_item, item: item_1, invoice: invoice_1)

      visit merchant_invoice_path(merchant, invoice_1)

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_1.status)
      expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d, %Y"))
      within ".customer" do
        expect(page).to have_content(invoice_1.customer.name)
      end
    end

    it "I see information of the items on the invoice" do
      merchant = create(:random_merchant)
      item_1 = create(:random_item, merchant: merchant)
      invoice_1 = create(:random_invoice)
      invoice_item_1 = create(:random_invoice_item, item: item_1, invoice: invoice_1)

      visit merchant_invoice_path(merchant, invoice_1)

      within ".show"
    end
  end
end
