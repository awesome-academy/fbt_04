class CreateBookingTours < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_tours do |t|
      t.integer :user_id
      t.integer :tour_id
      t.integer :status
      t.integer :payment

      t.timestamps
    end
  end
end
