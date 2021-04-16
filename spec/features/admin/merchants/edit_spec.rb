require 'rails_helper'

RSpec.describe 'admin merchants edit page' do
  before :each do
    @merchant = create(:random_merchant)
  end

  context 'you are on the merchant show page' do
    it 'the update merchant link takes you to the merchant edit page' do
      visit "/admin/merchants/#{@merchant.id}"

      click_on 'Update Merchant'

      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/edit")
    end
  end

  context 'you are on the merchant edit page' do
    it 'the edit page form comes pre-filled' do
      visit "/admin/merchants/#{@merchant.id}/edit"

      expect(find_field('Name').value).to eq(@merchant.name)
    end

    it 'submitting a changed name will route to the updated show page' do
      visit "/admin/merchants/#{@merchant.id}/edit"

      fill_in 'Name', with: 'New Name'
      click_on 'Update Merchant'

      expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
      expect(page).to have_content('New Name')
      expect(page).to have_content('Name successfully changed!')
    end
    
    it 'submitting a blank name will return an error message' do
      visit "/admin/merchants/#{@merchant.id}/edit"

      fill_in 'Name', with: ''
      click_on 'Update Merchant'

      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/edit")
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end