class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :activation_token, :remember_token
  has_many :booking_tours, dependent: :destroy
  has_many :rating_tours, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :imagerelations, as: :imagetable, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :fullname, presence: true, length: {
    maximum: Settings.user.length.name
  }
  validates :email, length: {maximum: Settings.user.length.email},
            presence: true, format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: Settings.user.length.password},
    allow_nil: true
  enum role: {user: 0, admin: 1}
  before_save :downcase_email
  before_create :create_activation_digest
  scope :by_name, ->(name){where("fullname like ?", "%#{name}%")}
  scope :sort_newest, ->{order created_at: :desc}

  class << self
    def digest string
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Password.create(string, cost: BCrypt::Engine::MIN_COST)
      else
        BCrypt::Password.create(string, cost: BCrypt::Engine.cost)
      end
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.active_digest = User.digest(activation_token)
  end
end
