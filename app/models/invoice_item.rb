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
      "select item.merchant_id as merchant_id, item.name as item_name,
      item.id as item_id, ii.status, inv.id as invoice_id, inv.created_at as created_at
        from invoice_items ii
          inner join items item
          ON ii.item_id=item.id
          inner join invoices inv
          ON ii.invoice_id=inv.id
          WHERE item.merchant_id=#{merchant.id}
          and ii.status != 2
          ORDER BY created_at"

    )
  end
end
