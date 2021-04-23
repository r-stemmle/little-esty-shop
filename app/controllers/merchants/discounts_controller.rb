class Merchants::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
    @upcoming_holidays = NagerService.new(Time.now.year).next_three_holidays
  end
end
