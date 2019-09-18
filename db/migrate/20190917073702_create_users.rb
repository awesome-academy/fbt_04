class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.integer :active
      t.string :active_digest
      t.integer :authenticate

      t.timestamps
    end
  end
end
