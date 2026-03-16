class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum :making_status, {
    cannot_start: 0,
    waiting_for_production: 1,
    in_production: 2,
    production_completed: 3
  }

  validates :price, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def making_status_label
    I18n.t("activerecord.attributes.order_detail.making_statuses.#{making_status}")
  end
end
