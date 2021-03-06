class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username,
            presence: true,
            length: { minimum: 2, maximum: 25 },
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  validates :description,
            length: { maximum: 250 }

  validates :password,
            presence: true, on: :create

  has_secure_password

  scope :display_online_users, -> { where(active: true) }
end
