class AddNamePhoneAddressToBookingTours < ActiveRecord::Migration[5.2]
  def change
    add_column :booking_tours, :name, :string
    add_column :booking_tours, :phone, :integer
    add_column :booking_tours, :address, :string
  end
end
