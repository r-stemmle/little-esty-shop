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

  def total_discounts
    discount = 0
    invoice_items.each do |invoice_item|
      if invoice_item.qualified_discount == "No Discounts"
        discount += 0
      else
        discount += (invoice_item.qualified_discount.percent * (invoice_item.unit_price * invoice_item.quantity)).to_f
      end
    end
    discount
  end
end
