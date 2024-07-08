class CreateGiftCustomizations < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_customizations do |t|
      t.references :gift, null: false, foreign_key: true
      t.references :customization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
