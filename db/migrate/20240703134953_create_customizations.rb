class CreateCustomizations < ActiveRecord::Migration[7.1]
  def change
    create_table :customizations do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
