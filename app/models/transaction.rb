class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: [:failed, :success]

  validates :credit_card_number, presence: true, length: {is: 16}
end
