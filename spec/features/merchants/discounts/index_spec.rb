require 'rails_helper'

RSpec.describe "Buld Discounts Index Page" do
  before :each do
    @merchant = create(:random_merchant)
    @discount_1 = create(:random_discount, merchant_id: @merchant.id)
    @discount_2 = create(:random_discount, merchant_id: @merchant.id)
    @discount_3 = create(:random_discount, merchant_id: @merchant.id)
    @discount_4 = create(:random_discount, merchant_id: @merchant.id)
    @discount_5 = create(:random_discount, merchant_id: @merchant.id)
    @discount_6 = create(:random_discount, merchant_id: @merchant.id)
    visit merchant_discounts_path(@merchant)
  end

  describe "As a merchant, when I visit my merchant dashboard" do
    it "I see a link to view all my discounts" do
      expect(page).to have_link('View Discounts')
    end
  end


end
