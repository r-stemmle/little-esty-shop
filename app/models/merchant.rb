class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  validates_presence_of :name

  def ready_to_ship
    items.joins(:invoice_items).joins(:invoices).select('invoice_items.*, items.*, invoices.created_at').where('invoice_items.status != 2')
  end

  def favorite_customers
    binding.pry
  end


end
