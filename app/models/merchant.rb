class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  def ready_to_ship
    items.not_shipped
  end
end
