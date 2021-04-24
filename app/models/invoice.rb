class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :transactions, dependent: :destroy

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: [:"in progress", :cancelled, :completed]

  def self.where_not_successful
    self.joins(:invoice_items)
        .where.not("invoice_items.status=2")
        .order(:created_at)
        .distinct
  end

  def total_revenue
    invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def total_revenue_with_discounts
    initial_revenue = invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
    binding.pry
    #calculate bulk discount
      #(invoice_items.unit_price * discount.percent) * invoice_items.quantity
    #subtract bulk discount
  end
end
