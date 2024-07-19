class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.string :RUT
      t.string :social_reason
      t.integer :price
      t.references :payment_method, null: false, foreign_key: true
      t.references :gift, null: false, foreign_key: true
      t.boolean :suprise_delivery
      t.string :personalization
      t.boolean :resend_delivery

      t.timestamps
    end
  end
end
