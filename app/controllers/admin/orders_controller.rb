class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :order_details)
                   .order(created_at: :desc)

    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      @orders = @orders.where(customer_id: @customer.id)
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
