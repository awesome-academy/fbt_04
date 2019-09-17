class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :user_id
      t.integer :parent_comment

      t.timestamps
    end
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
