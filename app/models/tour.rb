class Tour < ApplicationRecord
  scope :sort_by_created_at, ->{order created_at: :desc}
  belongs_to :category
  has_many :bokking_tours
  has_many :reviews
  has_many :comments, as: :commentable
end
