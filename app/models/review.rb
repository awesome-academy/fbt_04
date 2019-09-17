class Review < ApplicationRecord
  has_many :reactions
  belongs_to :tour
  has_many :comments
  has_many :comments, as: :commentable
end
