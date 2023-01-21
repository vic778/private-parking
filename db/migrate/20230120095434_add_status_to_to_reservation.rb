class AddStatusToToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :status, :string, default: "pending"
  end
end
