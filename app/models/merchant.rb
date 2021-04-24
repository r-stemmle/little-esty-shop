class Merchant < ApplicationRecord
  default_scope {order(:name)}
  has_many :discounts
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def self.all_enabled
    where(enabled: true)
  end

  def self.all_disabled
    where(enabled: false)
  end

  def top_five_customers
    invoices.joins(:customer).joins(:transactions)
            .select("customers.id, customers.last_name as lname, customers.first_name as name, count(transactions.id) as count")
            .where("transactions.result=1")
            .group("customers.id")
            .order("count desc")
            .limit(5)
  end

  def top_five_items
    invoices.joins(:transactions)
            .select("items.name as item_name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
            .where(transactions: {result: 1})
            .group(:item_name)
            .order(revenue: :desc)
            .limit(5)
  end
end
