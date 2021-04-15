class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  def ready_to_ship
    items.joins(:invoice_items).select('invoice_items.*, items.*').where('invoice_items.status != 2')
  end


end
