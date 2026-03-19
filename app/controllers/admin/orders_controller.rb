class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :order_details)
                   .order(created_at: :desc)
  end
end
