class Public::ItemsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[index show]

  def index
    @items = Item.where(is_active: true)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
