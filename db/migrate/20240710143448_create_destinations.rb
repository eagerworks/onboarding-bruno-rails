class CreateDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :destinations do |t|
      t.string :receiver
      t.date :day
      t.string :address
      t.string :number
      t.string :schedules
      t.string :cost
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
