class MerchantsController < ApplicationController

  def dashboard
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])

  end

end
