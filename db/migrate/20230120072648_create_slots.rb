class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.string :name
      t.float :price
      t.datetime :open_time
      t.datetime :close_time
      t.integer :status, default: 0
      t.references :slot_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
