require 'rails_helper'

RSpec.describe "As a Merchant" do
  before { @merchant = create(:random_merchant) }
  context "When I visit my merchant dashboard" do
    it "I see the name of my merchant" do
      visit merchant_dashboard_path(@merchant)

      expect(page).to have_content(@merchant.name)
    end

    it "I see a link to my merchant items and invoices index" do
      visit merchant_dashboard_path(@merchant)

      expect(page).to have_link('My Items')
      expect(page).to have_link('My Invoices')
    end

    it "I see a list of items ordered but not shipped yet with invoice id link" do
      item_1 = create(:random_item, merchant_id: @merchant.id)
      item_2 = create(:random_item, merchant_id: @merchant.id)
      item_3 = create(:random_item, merchant_id: @merchant.id)
      item_4 = create(:random_item, merchant_id: @merchant.id)
      item_5 = create(:random_item, merchant_id: @merchant.id)
      item_6 = create(:random_item, merchant_id: @merchant.id)
      invoice_item_1 = create(:random_invoice_item, item: item_1, status: 0)
      invoice_item_2 = create(:random_invoice_item, item: item_2, status: 1)
      invoice_item_3 = create(:random_invoice_item, item: item_3, status: 0)
      invoice_item_4 = create(:random_invoice_item, item: item_4, status: 1)
      invoice_item_5 = create(:random_invoice_item, item: item_5, status: 0)
      invoice_item_6 = create(:random_invoice_item, item: item_6, status: 2)
      item_7 = create(:random_item)


      visit merchant_dashboard_path(@merchant)

      within ".merchant-items" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_4.name)
        expect(page).to have_content(item_5.name)
        expect(page).to_not have_content(item_6.name)
        expect(page).to_not have_content(item_7.name)
        save_and_open_page
        expect(page).to have_link(
          invoice_item_1.invoice_id,
          href: "merchants/#{@merchant.id}/invoices/#{invoice_item_1.invoice_id}"
        )
      end

    end

    it "I see the date the invoice was created, oldest to newest" do
      item_1 = create(:random_item, merchant_id: @merchant.id)
      item_2 = create(:random_item, merchant_id: @merchant.id)
      item_3 = create(:random_item, merchant_id: @merchant.id)
      item_4 = create(:random_item, merchant_id: @merchant.id)
      item_5 = create(:random_item, merchant_id: @merchant.id)
      item_6 = create(:random_item, merchant_id: @merchant.id)
      invoice_item_1 = create(:random_invoice_item, item: item_1, status: 0)
      invoice_item_2 = create(:random_invoice_item, item: item_2, status: 1)
      invoice_item_3 = create(:random_invoice_item, item: item_3, status: 0)
      invoice_item_4 = create(:random_invoice_item, item: item_4, status: 1)
      invoice_item_5 = create(:random_invoice_item, item: item_5, status: 0)
      invoice_item_6 = create(:random_invoice_item, item: item_6, status: 2)
      item_7 = create(:random_item)
      save_and_open_page

      visit merchant_dashboard_path(@merchant)

      within ".merchant-items" do
        expect(page).to have_content(invoice_item_1.invoice.created_at.strftime("%A, %B %d, %Y"))
      end


    end

  end
end
