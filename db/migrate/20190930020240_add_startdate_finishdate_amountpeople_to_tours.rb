class AddStartdateFinishdateAmountpeopleToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :startdate, :datetime
    add_column :tours, :finishdate, :datetime
    add_column :tours, :amountpeople, :int
  end
end
