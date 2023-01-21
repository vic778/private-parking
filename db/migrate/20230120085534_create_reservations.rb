class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.datetime :from 
      t.datetime :to
      t.string :total_price
      t.string :slot_type
      t.references :slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
