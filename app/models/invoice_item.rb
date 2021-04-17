class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:packaged, :pending, :shipped]

  validates_presence_of :quantity, :unit_price

  def self.lines_not_shipped
    where('status != ?', 2)
  end

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
end
