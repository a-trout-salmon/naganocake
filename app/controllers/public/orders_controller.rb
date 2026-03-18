class Public::OrdersController < Public::ApplicationController
  

  # 注文情報入力画面
  def new
    @order = Order.new
  end

  # 注文確認画面
  def confirm
    @order = Order.new(order_params)

    case params[:order][:address_option]
    when "0" # 自分の住所
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.last_name + current_customer.first_name

    when "1" # 登録済住所
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address     = address.address
      @order.name        = address.name

    when "2" # 新しい住所
      # 入力された値そのまま
    end

    @cart_items = current_customer.cart_items

    @total = @cart_items.sum do |cart_item|
      cart_item.item.with_tax_price * cart_item.amount
    end
  end

  # 注文確定
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800

    cart_items = current_customer.cart_items

    total = cart_items.sum do |cart_item|
      cart_item.item.with_tax_price * cart_item.amount
    end

    @order.total_payment = total + @order.postage

    if @order.save
      cart_items.each do |cart_item|
        OrderDetail.create(
          order_id: @order.id,
          item_id: cart_item.item_id,
          amount: cart_item.amount,
          price: cart_item.item.with_tax_price,
          making_status: 0
        )
      end

      cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :new
    end
  end

  # 注文完了画面
  def complete
  end

  # 注文履歴一覧
  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  # 注文詳細
  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(
      :payment_method,
      :postal_code,
      :address,
      :name
    )
  end
end
