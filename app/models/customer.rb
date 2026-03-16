class User < ApplicationRecord
  has_secure_password

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :items, through: :cart_items, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true, uniqueness: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
  validates :is_active, inclusion: { in: [true, false] }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
