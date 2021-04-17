class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:packaged, :pending, :shipped]

  validates_presence_of :quantity, :unit_price

  def self.lines_not_shipped
    where('status != ?', 2)
  end

  # this currently returns all merchant_id's by highest revenue
  def self.highest_revenue_merchant_ids
    joins(:item, invoice: :transactions)
    .select("items.merchant_id, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .where("transactions.result = 1")
    .group("items.merchant_id")
    .order(revenue: :desc)
    .limit(5)
  end
end
