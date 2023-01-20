class AddReferenceParkingToSlottype < ActiveRecord::Migration[7.0]
  def change
    add_reference :slot_types, :parking, foreign_key: true, null: false
  end
end
