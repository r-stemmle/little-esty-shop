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
        end
        
        within '#disabled_merchants' do
          expect(page).to have_content(@merchant_2.name)
          expect(page).to_not have_content(@merchant_1.name)
        end
      end
    end
  end
end