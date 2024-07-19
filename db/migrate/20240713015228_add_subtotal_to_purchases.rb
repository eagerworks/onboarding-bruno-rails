class AddSubtotalToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :subtotal, :integer
  end
end
