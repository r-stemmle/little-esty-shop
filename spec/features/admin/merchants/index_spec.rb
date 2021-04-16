require 'rails_helper'

RSpec.describe 'admin merchant index spec' do
  before :each do
    @merchant_1 = create(:random_merchant)
    @merchant_2 = create(:random_merchant)

    visit '/admin/merchants'
  end

  context 'when I visit the admin merchant index page' do
    it 'i see the names of all the merchants as links to their show page' do
      expect(page).to have_link("#{@merchant_1.name}")
      expect(page).to have_link("#{@merchant_2.name}")
    end
  end
end