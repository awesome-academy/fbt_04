class Review < ApplicationRecord
  has_many :reactions
  belongs_to :tour
  has_many :comments
  has_many :comments, as: :commentable
  belongs_to :user
  scope :sort_by_created_at, ->{order created_at: :desc}
  scope :includes_user_and_tour, ->{includes :user, :tour}
end
