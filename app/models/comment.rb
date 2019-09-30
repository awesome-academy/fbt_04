class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, class_name: Comment.name,
    foreign_key: :parent_comment, dependent: :destroy
  scope :sort_by_created_at, ->{order created_at: :desc}
end
