class Merchant < ApplicationRecord
  default_scope {order(:name)}

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

  def top_five_customers(merchant_id)
    customers.find_by_sql("select c.*, count(t.id) as count from customers c
                            INNER JOIN invoices i on c.id=i.customer_id
                            INNER JOIN transactions t on i.id=t.invoice_id
                            INNER JOIN invoice_items it on i.id=it.invoice_id
                            INNER JOIN items ms on ms.id=it.item_id
                            INNER JOIN merchants m on m.id=ms.merchant_id
                            WHERE ms.merchant_id=#{merchant_id} and t.result=1
                            GROUP BY c.id
                            order by count desc
                            limit 5"
                            )
  end

  def top_five_items
    items.joins(invoice_items:, invoices: :transaction)
  end
end
