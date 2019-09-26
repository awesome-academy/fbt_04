class CreateImagerelations < ActiveRecord::Migration[5.2]
  def change
    create_table :imagerelations do |t|
      t.references :user, foreign_key: true
      t.string :imagetable_type
      t.bigint :imagetable_id
      t.string :picture

      t.timestamps
    end
  end
end
