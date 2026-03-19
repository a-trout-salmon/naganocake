class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :order_details)
                   .order(created_at: :desc)

    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      @orders = @orders.where(customer_id: @customer.id)
    end
  end
end