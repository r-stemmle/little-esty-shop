require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
  end

  describe "validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe 'class methods' do
    before {
      @customer_1 = create(:random_customer)
      @customer_2 = create(:random_customer)
      @customer_3 = create(:random_customer)
      @customer_4 = create(:random_customer)
      @customer_5 = create(:random_customer)
      @customer_6 = create(:random_customer)
    }

    context '.top_customers' do
      it 'returns the top 5 customers with the most successful transactions' do
        invoice_1 = create(:random_invoice, customer: @customer_1)
        invoice_2 = create(:random_invoice, customer: @customer_2)
        invoice_3 = create(:random_invoice, customer: @customer_3)
        invoice_4 = create(:random_invoice, customer: @customer_4)
        invoice_5 = create(:random_invoice, customer: @customer_5)
        invoice_6 = create(:random_invoice, customer: @customer_6)

        transaction_1 = create(:random_transaction, result: 1, invoice: invoice_1)
        transaction_2 = create(:random_transaction, result: 1, invoice: invoice_2)
        transaction_3 = create(:random_transaction, result: 1, invoice: invoice_3)
        transaction_4 = create(:random_transaction, result: 1, invoice: invoice_4)
        transaction_5 = create(:random_transaction, result: 1, invoice: invoice_5)
        transaction_6 = create(:random_transaction, result: 0, invoice: invoice_6)
        transaction_7 = create(:random_transaction, result: 1, invoice: invoice_5)

        expect(Customer.top_customers).to eq([@customer_5, @customer_1, @customer_2, @customer_3, @customer_4])
      end
    end

    context ".find_by_merchant()" do
      it "returns all customers of a merchant" do
        invoice_1 = create(:random_invoice, customer: @customer_1)
        invoice_2 = create(:random_invoice, customer: @customer_2)
        invoice_3 = create(:random_invoice, customer: @customer_3)
        invoice_4 = create(:random_invoice, customer: @customer_4)
        invoice_5 = create(:random_invoice, customer: @customer_5)
        invoice_6 = create(:random_invoice, customer: @customer_6)

        transaction_1 = create(:random_transaction, result: 1, invoice: invoice_1)
        transaction_2 = create(:random_transaction, result: 1, invoice: invoice_2)
        transaction_3 = create(:random_transaction, result: 1, invoice: invoice_3)
        transaction_4 = create(:random_transaction, result: 1, invoice: invoice_4)
        transaction_5 = create(:random_transaction, result: 1, invoice: invoice_5)
        transaction_6 = create(:random_transaction, result: 0, invoice: invoice_6)
        transaction_7 = create(:random_transaction, result: 1, invoice: invoice_5)
      end
    end
  end

  describe 'instance methods' do
    context '#total_purchases' do
      it 'returns total number of successful transactions' do
        customer = create(:random_customer)
        invoice = create(:random_invoice, customer: customer)
        create(:random_transaction, result: 1, invoice: invoice)
        create(:random_transaction, result: 1, invoice: invoice)

        expect(customer.total_purchases).to eq(2)
      end
    end

    context "#name" do
      it "returns the full name of a customer" do
        customer_1 = create(:random_customer)
        expect(customer_1.name).to eq(customer_1.first_name + " " + customer_1.last_name)
      end
    end
  end
end
