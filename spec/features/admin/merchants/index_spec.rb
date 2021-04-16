require 'rails_helper'

RSpec.describe 'admin merchant index spec' do
  before :each do
    @merchant_1 = create(:random_merchant, enabled: true)
    @merchant_2 = create(:random_merchant, enabled: false)

    visit '/admin/merchants'
  end

  context 'when I visit the admin merchant index page' do
    it 'i see the names of all the merchants as links to their show page' do
      expect(page).to have_link("#{@merchant_1.name}")
      expect(page).to have_link("#{@merchant_2.name}")
    end

    context 'when looking at merchants' do
      it 'shows all enabled & disabled' do
        within '#enabled_merchants' do
          expect(page).to have_content(@merchant_1.name)
          expect(page).to_not have_content(@merchant_2.name)
          expect(page).to have_button('Disable')
        end
        
        within '#disabled_merchants' do
          expect(page).to have_content(@merchant_2.name)
          expect(page).to_not have_content(@merchant_1.name)
          expect(page).to have_button('Enable')
        end
      end

      it 'disable button works properly' do
        within '#disabled_merchants' do
          click_on 'Enable'
          expect(current_path).to eq('/admin/merchants')
          expect(page).to_not have_content(@merchant_2.name)
        end
      end

      it 'enable button works properly' do
        within '#enabled_merchants' do
          click_on 'Disable'
          expect(current_path).to eq('/admin/merchants')
          expect(page).to_not have_content(@merchant_1.name)
        end
      end
    end
  end
end