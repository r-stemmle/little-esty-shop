module Admin
  class MerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
    end
    
    def show
      @merchant = Merchant.find(params[:id])
    end

    def toggle_enabled
      @merchant = Merchant.find(params[:id])

      @merchant.toggle!(:enabled)
      redirect_to admin_merchants_path
    end
  end
end