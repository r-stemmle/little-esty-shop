class Merchant < ApplicationRecord
  default_scope {order(:name)}

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.all_enabled
    where(enabled: true)
  end


  def self.all_disabled
    where(enabled: false)
  end

  def self.top_merchants
    find_by_sql('SELECT
      *,
      SUM ( invoice_items.unit_price * invoice_items.quantity) AS revenue
    FROM
      merchants
      INNER JOIN items ON merchants."id" = items.merchant_id
      INNER JOIN invoice_items ON items."id" = invoice_items.item_id
      INNER JOIN invoices ON invoice_items.invoice_id = invoices."id"
      INNER JOIN transactions ON invoices."id" = transactions.invoice_id
    WHERE
      transactions."result" = 1
    GROUP BY
      merchants."id",
      items."id",
      invoice_items."id",
      invoices."id",
      transactions."id"
    ORDER BY
      revenue DESC')
  end

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
