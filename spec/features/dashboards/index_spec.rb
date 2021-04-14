require 'rails_helper'

RSpec.describe "As a Merchant" do
  before {
    @merchant = create(:random_merchant)
  }
  context "When I visit my merchant dashboard" do
    it "I see the name of my merchant" do
      visit merchant_dashboard_path(@merchant)

      expect(page).to have_content(@merchant.name)

    end
  end
end
