module Admin
  class MerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
      @invoice_items = InvoiceItem.all
    end

    def show
      @merchant = Merchant.find(params[:id])
    end

    def new
      @merchant = Merchant.new
    end

    def create
      merchant = Merchant.new(merchant_params)

      if merchant.save
        redirect_to admin_merchants_path
      else
        redirect_to new_admin_merchant_path
        flash[:error] = "Error: #{error_message(merchant.errors)}"
      end
    end

    def edit
      @merchant = Merchant.find(params[:id])
    end

    def update
      merchant = Merchant.find(params[:id])

      if merchant.update(merchant_params)
        redirect_to admin_merchant_path(merchant)
        flash[:success] = 'Name successfully changed!'
      else
        redirect_to edit_admin_merchant_path(merchant)
        flash[:error] = "Error: #{error_message(merchant.errors)}"
      end
    end

    def toggle_enabled
      @merchant = Merchant.find(params[:id])

      @merchant.toggle!(:enabled)
      redirect_to admin_merchants_path
    end

    private
    def merchant_params
      params.require(:merchant).permit(:name)
    end
  end
end