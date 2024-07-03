class CreateGiftCategorizations < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_categorizations do |t|
      t.references :gift, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
