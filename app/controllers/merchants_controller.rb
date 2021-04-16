class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:merchant_id])
    @customer = Customer.find_by_merchant(@merchant.id)
  end

end
