class Admin < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
