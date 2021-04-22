require 'rails_helper'

RSpec.describe "Buld Discounts Index Page" do
  before :each do
    @merchant = create(:random_merchant)
    @discount_1 = create(:random_discount, percent: 0.10, quantity: 10, merchant_id: @merchant.id)
    @discount_2 = create(:random_discount, percent: 0.20, quantity: 20, merchant_id: @merchant.id)
    @discount_3 = create(:random_discount, percent: 0.30, quantity: 30, merchant_id: @merchant.id)
    @discount_4 = create(:random_discount, percent: 0.40, quantity: 40, merchant_id: @merchant.id)
    @discount_5 = create(:random_discount, percent: 0.50, quantity: 50, merchant_id: @merchant.id)
    @discount_6 = create(:random_discount, percent: 0.60, quantity: 60, merchant_id: @merchant.id)

  end

  describe "As a merchant, when I visit my merchant dashboard" do
    it "I see a link to view all my discounts and I click it" do
      visit merchant_dashboard_index_path(@merchant)
      expect(page).to have_link('View Discounts')
      click_on "View Discounts"
      expect(current_path).to eq(merchant_discounts_path(@merchant))
    end
  end

  describe "When I am taken to my bulk discounts index page"
    before :each do
      visit merchant_discounts_path(@merchant)
    end
    it "I see all of my bulk discounts listed as links" do
      expect(page).to have_link("#{@discount_1.id}")
      expect(page).to have_content('10%')
      expect(page).to have_content(@discount_1.quantity)
      expect(page).to have_link("#{@discount_2.id}")
      expect(page).to have_content('20%')
      expect(page).to have_content(@discount_2.quantity)
      expect(page).to have_link("#{@discount_3.id}")
      expect(page).to have_content('30%')
      expect(page).to have_content(@discount_3.quantity)
      expect(page).to have_link("#{@discount_4.id}")
      expect(page).to have_content('40%')
      expect(page).to have_content(@discount_4.quantity)
      expect(page).to have_link("#{@discount_5.id}")
      expect(page).to have_content('50%')
      expect(page).to have_content(@discount_5.quantity)
      expect(page).to have_link("#{@discount_6.id}")
      expect(page).to have_content('60%')
      expect(page).to have_content(@discount_6.quantity)

    end


end
