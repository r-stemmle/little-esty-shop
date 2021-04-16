require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :items}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
    before do
      @merchant_1 = create(:random_merchant, enabled: true)
      @merchant_2 = create(:random_merchant, enabled: false)
    end
    
    it '.all_enabled' do
      expect(Merchant.all_enabled).to eq([@merchant_1])
    end

    it '.all_disabled' do
      expect(Merchant.all_disabled).to eq([@merchant_2])
    end
  end
end
