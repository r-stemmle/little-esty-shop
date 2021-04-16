require 'rails_helper'

RSpec.describe 'admin merchant show page' do
    
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