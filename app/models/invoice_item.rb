class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:packaged, :pending, :shipped]

  validates_presence_of :quantity, :unit_price
end
