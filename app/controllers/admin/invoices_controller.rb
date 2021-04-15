class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])

    if invoice.update(invoice_params)
      redirect_to admin_invoice_path(invoice)
    elsif
      redirect_to admin_invoice_path(invoice)
      flash[:error_explanation] = "Error: #{error_message(invoice.errors)}"
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status, :customer_id)
  end
end