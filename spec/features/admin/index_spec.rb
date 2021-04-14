require 'rails_helper'

describe 'admin index page' do
  context 'when you arrive at the page' do
    it 'shows a header that you are on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it 'shows links to dashboard, merchants, and invoices' do
      visit "/admin"

      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Invoices")
    end
  end

  context 'you have invoices that have some items shipped' do
    it 'shows all of the invoices with no items shipped in order' do
      invoice = create(:random_invoice)
      invoice_2 = create(:random_invoice)
      invoice_3 = create(:random_invoice)

      invoice_item_1 = create(:random_invoice_item, status: 2, invoice: invoice)
      invoice_item_2 = create(:random_invoice_item, status: 1, invoice: invoice_2)
      invoice_item_3 = create(:random_invoice_item, status: 0, invoice: invoice_3)

      visit "/admin"

      expect(page).to_not have_content(invoice.id)
      expect(page).to have_content(invoice_2.id)
      expect(page).to have_content(invoice_3.id)
      expect("#{invoice_2.id}").to appear_before("#{invoice_3.id}")
    end
  end
end