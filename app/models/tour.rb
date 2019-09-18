class Tour < ApplicationRecord
  belongs_to :category
  has_many :bokking_tours
  has_many :reviews
  has_many :comments, as: :commentable
end
