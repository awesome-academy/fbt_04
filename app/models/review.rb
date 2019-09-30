class Review < ApplicationRecord
  has_many :reactions
  belongs_to :tour
  has_many :comments
  has_many :comments, as: :commentable
  has_many :imagerelations, as: :imagetable, dependent: :destroy
  belongs_to :user
  scope :sort_by_created_at, ->{order created_at: :desc}
  scope :includes_user_and_tour, ->{includes :user, :tour}
  validates :content, length: {maximum: Settings.review.length},
    presence: true
end
