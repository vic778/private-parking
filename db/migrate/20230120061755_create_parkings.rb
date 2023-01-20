class CreateParkings < ActiveRecord::Migration[7.0]
  def change
    create_table :parkings do |t|
      t.string :name
      t.string :address
      t.datetime :open_time
      t.datetime :close_time

      t.timestamps
    end
  end
end
