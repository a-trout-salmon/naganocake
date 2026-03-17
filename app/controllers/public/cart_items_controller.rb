class Public::CartItemsController < Public::ApplicationController
  def index
    @cart_items = current_customer.cart_items.includes(:item)
  end

  def create
    item_id = cart_item_params[:item_id].to_i
    amount = cart_item_params[:amount].to_i

    cart_item = current_customer.cart_items.find_by(item_id: item_id)

    if cart_item.present?
      cart_item.amount += amount
      cart_item.save
    else
      cart_item = current_customer.cart_items.new(cart_item_params)
      cart_item.save
    end

    redirect_to cart_items_path
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end