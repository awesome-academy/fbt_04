class AddAmountpeopleToBookingTours < ActiveRecord::Migration[5.2]
  def change
    add_column :booking_tours, :amountpeople, :int
  end
end
