class Merchant < ApplicationRecord
  default_scope {order(:name)}

  has_many :items, dependent: :destroy

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
end