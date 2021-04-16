require 'rails_helper'

RSpec.describe 'new merchant page' do
  context 'you are on the admin merchant index' do
    it 'the new merchant link takes you to the new merchant page' do
      visit '/admin/merchants'

      click_on 'New Merchant'
      expect(current_path).to eq('/admin/merchants/new')
    end
  end

  context 'you are on the new merchant page' do
    before :each do
      visit '/admin/merchants/new'
    end
    
    it 'filling in the form with a name redirects you to the admin merchants index with the merchant you created' do
      fill_in 'Name', with: 'Fake Merchant'
      click_on 'Create Merchant'

      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content('Fake Merchant')
    end

    it 'submitting a blank form gives an error message' do
      click_on 'Create Merchant'

      expect(current_path).to eq('/admin/merchants/new')
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end