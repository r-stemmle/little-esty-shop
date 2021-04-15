require 'rails_helper'

describe 'admin invoice index page' do
  context 'you land on the page' do
    before {
      @invoice = create(:random_invoice)

      visit 'admin/invoices'
    }

    it 'shows you a invoices header' do
      within("div#admin_invoice_container_header") do
        expect(page).to have_content("Invoices")
      end
    end

    it 'shows you all the invoices with a link to the show page' do
      within("div#admin_invoice_container_body") do
        expect(page).to have_link("#{@invoice.id}")
      end
    end
  end
end