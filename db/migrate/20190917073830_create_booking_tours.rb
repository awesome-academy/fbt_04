class CreateBookingTours < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_tours do |t|
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true
      t.integer :status, default: 1
      t.integer :payment

      t.timestamps
    end
  end
end
