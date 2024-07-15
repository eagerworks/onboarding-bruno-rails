class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :owner
      t.string :card_number
      t.date :due_date
      t.string :CVV
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
