class Merchants::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
    @upcoming_holidays = NagerService.new(Time.now.year).next_three_holidays
  end

  def new

  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(discount_params)
    discount.merchant_id = params[:merchant_id]
    if discount.save
      redirect_to merchant_discounts_path(merchant)
    else
      redirect_to new_merchant_discount_path(merchant)
      flash[:error] = "Error: #{error_message(discount.errors)}"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(merchant)
  end


  private

  def discount_params
    params.require(:discount).permit(:percent, :quantity)
  end
end
