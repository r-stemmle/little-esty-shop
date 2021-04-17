class Merchants::InvoicesController < ApplicationController
  def index

    @merchant = Merchant.find(params[:merchant_id])
    @invoice_items = InvoiceItem.by_merchant(@merchant)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
