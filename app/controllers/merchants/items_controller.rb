class Merchants::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @items = Item.find(params[:id])
  end
end
