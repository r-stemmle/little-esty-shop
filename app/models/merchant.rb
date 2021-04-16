class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  def self.all_enabled
    where(enabled: true)
  end

  def self.all_disabled
    where(enabled: false)
  end
end
