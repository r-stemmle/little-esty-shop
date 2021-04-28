class Discount < ApplicationRecord
  validates :percent, :quantity, presence: true

  belongs_to :merchant
  has_many :items, through: :merchant

  def self.find_by_min_ordered(needed)
    where("quantity <= #{needed}").order(quantity: :desc).limit(1).first
  end
end
