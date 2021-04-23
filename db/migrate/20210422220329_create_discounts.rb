class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.decimal :percent, precision: 2, scale: 2
      t.integer :quantity
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
