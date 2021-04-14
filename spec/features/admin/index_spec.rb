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
end