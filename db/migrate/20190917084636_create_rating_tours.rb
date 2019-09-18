class CreateRatingTours < ActiveRecord::Migration[5.2]
  def change
    create_table :rating_tours do |t|
      t.integer :user_id
      t.integer :tour_id
      t.integer :rate

      t.timestamps
    end
  end
end
