class CreateJoinTablePurchasesCustomizations < ActiveRecord::Migration[7.1]
  def change
    create_join_table :purchases, :customizations do |t|
      t.index [:purchase_id, :customization_id]
      t.index [:customization_id, :purchase_id]

    end
    add_foreign_key :customizations_purchases, :purchases
    add_foreign_key :customizations_purchases, :customizations
  end
end
