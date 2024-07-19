class AddAmountToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :amount, :integer
  end
end
