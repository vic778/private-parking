class AddCancelledAtToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :cancelled_at, :datetime
    add_column :reservations, :cancellation_charge, :float
  end
end
