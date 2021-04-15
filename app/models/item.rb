class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description
  validates :unit_price, presence: true, numericality: true

  def self.not_shipped
      self.joins(:invoice_items)
          .where('status != ?', 2)
  end
end
