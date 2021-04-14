require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :items}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  # describe 'EXAMPLE' do
  #   before {
  #     @merchant_1 = create(:random_merchant)
  #     @merchant_2 = create(:random_merchant)
  #   }

  #   it 'EXAMPLE' do
  #     binding.pry
  #   end
  # end
end
