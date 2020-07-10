class User < ApplicationRecord
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

  has_secure_password
end
