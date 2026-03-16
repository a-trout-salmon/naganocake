class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  validates :price, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
