class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  has_many :discounts, through: :item

  enum status: [:packaged, :pending, :shipped]

  validates_presence_of :quantity, :unit_price

  def self.items_ready_to_ship(merchant)
    find_by_sql(
      "SELECT item.merchant_id AS merchant_id, item.name AS item_name,
      item.id AS item_id, ii.status, inv.id AS invoice_id, inv.created_at AS created_at
        FROM invoice_items ii
          INNER JOIN items item
          ON ii.item_id=item.id
          INNER JOIN invoices inv
          ON ii.invoice_id=inv.id
          WHERE item.merchant_id=#{merchant.id}
          AND ii.status != 2
          ORDER BY created_at"
    )
  end

  def self.by_merchant(merchant)
    merchant.invoices.uniq
  end

  def self.highest_revenue_merchant_ids
    joins(:item, invoice: :transactions)
    .select("items.merchant_id, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .where("transactions.result = 1")
    .group("items.merchant_id")
    .order(revenue: :desc)
    .limit(5)
  end

  def self.best_date_by_merchant_id(merchant_id)
    joins(:item, invoice: :transactions)
    .select("invoice_items.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .where("transactions.result = 1 AND items.merchant_id = ?", merchant_id)
    .group("invoice_items.created_at")
    .order(revenue: :desc)
    .limit(1)
    .first
    .created_at
  end

  def qualified_discount
    discount = discounts.find_by_min_ordered(self.quantity)
  end
end
