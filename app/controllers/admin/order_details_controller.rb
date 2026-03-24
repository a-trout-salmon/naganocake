class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])

    if order_detail.update(order_detail_params)
      order = order_detail.order

      if order_detail.in_production?
        order.update(status: :in_production)
      elsif order.order_details.where.not(making_status: :production_completed).none?
        order.update(status: :preparing_shipment)
      end

      redirect_to admin_order_path(order)
    else
      redirect_to admin_order_path(order_detail.order)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
