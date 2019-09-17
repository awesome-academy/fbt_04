class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name
      t.integer :price
      t.string :image
      t.string :place
      t.string :food
      t.string :new
      t.integer :category_id

      t.timestamps
    end
  end
end
