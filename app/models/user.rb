class User < ApplicationRecord
  has_many :booking_tours
  has_many :rating_tours
  has_many :comments
  has_many :reactions
  has_many :reviews
end
