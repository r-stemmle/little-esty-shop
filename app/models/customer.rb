class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_customers
    self.joins(invoices: [:transactions])
        .select('customers.*, count(transactions.*) as transactions_count')
        .where('transactions.result=1')
        .group(:id)
        .order(transactions_count: :desc)
        .limit(5)
  end

  def total_purchases
    invoices.joins(:transactions)
            .where(transactions: {result: 1})
            .count
  end
end
