class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  scope :sort_by_created_at, ->{order created_at: :desc}
end
