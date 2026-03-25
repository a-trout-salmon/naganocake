class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum :payment_method, {
    credit_card: 0,
    bank_transfer: 1
  }

  enum :status, {
    waiting_for_payment: 0,
    payment_confirmed: 1,
    in_production: 2,
    preparing_shipment: 3,
    shipped: 4
  }

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :payment_method, inclusion: { in: payment_methods.keys }

  def payment_method_label
    I18n.t("activerecord.attributes.order.payment_methods.#{payment_method}")
  end

  def status_label
    I18n.t("activerecord.attributes.order.statuses.#{status}")
  end
end
