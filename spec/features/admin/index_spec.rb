require 'rails_helper'

describe 'admin index page' do
  context 'when you arrive at the page' do
    it 'shows a header that you are on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("This is the Admin Dashboard")
    end
    it 'shows links to admin merchants index' do
      visit "/admin"

      expect(page).to have_link("Merchant Index")
    end
    it 'shows link to admin invoices index' do
      visit "/admin"

      expect(page).to have_link("Invoice Index")
    end
  end
end