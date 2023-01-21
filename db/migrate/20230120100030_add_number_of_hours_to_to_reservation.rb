class AddNumberOfHoursToToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :number_of_hours, :integer, default: 1
  end
end
