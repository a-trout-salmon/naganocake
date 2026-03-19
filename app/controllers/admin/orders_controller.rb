class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :order_details)
                   .order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to admin_order_path(@order), notice: "更新しました"
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
