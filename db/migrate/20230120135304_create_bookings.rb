class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.datetime :arrival_time
      t.datetime :left_time
      t.float :total_price
      t.string :ref_code
      t.string :license_plate
      t.references :slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
