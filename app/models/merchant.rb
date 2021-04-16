class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name

  def ready_to_ship
    items.joins(:invoice_items)
         .joins(:invoices).select('invoice_items.*, items.*, invoices.created_at')
         .where('invoice_items.status != 2')
  end

  def top_five_customers
    customers.joins(:transactions)
             .select("customers.*, count(transactions.*) as transactions_count")
             .where(transactions: {result: 1})
             .group(:id)
             .order(transactions_count: :desc)
             .limit(5)
  end
end
