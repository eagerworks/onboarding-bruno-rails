class CreateGifts < ActiveRecord::Migration[7.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :price
      t.float :valoration
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
