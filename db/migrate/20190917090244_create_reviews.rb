class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :tour_id
      t.integer :user_id
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
