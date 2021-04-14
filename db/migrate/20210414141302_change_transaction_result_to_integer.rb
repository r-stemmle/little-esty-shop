class ChangeTransactionResultToInteger < ActiveRecord::Migration[5.2]
  def up
    change_column :transactions, :result, 'integer USING CAST(result AS integer)'
  end

  def down
    change_column :transactions, :result, :integer
  end
end
