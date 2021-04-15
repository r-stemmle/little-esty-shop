class AdminController < ApplicationController
  def index
    @invoices = Invoice.all
    @customer = Customer.all
  end
end