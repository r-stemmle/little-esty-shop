require 'rails_helper'

RSpec.describe 'admin merchant show page' do
    context 'you are on the admin merchants index page' do
        it 'merchant name link brings you to show page' do
            merchant = create(:random_merchant)

            visit '/admin/merchants'
            
            click_on "#{merchant.name}"
            expect(current_path).to eq("/admin/merchants/#{merchant.id}")
        end
    end
    context 'you arrive on the page' do
        before :each do
            @merchant = create(:random_merchant)

            visit "/admin/merchants/#{@merchant.id}"
        end
        
        it 'shows the merchant name' do
            expect(page).to have_content(@merchant.name)
        end

        it 'shows link to update merchant' do
            expect(page).to have_link('Update Merchant')
        end
    end
    
end