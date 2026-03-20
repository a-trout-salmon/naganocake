class Public::ItemsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[index show]

  def index
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = Item.where(is_active: true, genre_id: @genre.id)
    else
      @items = Item.where(is_active: true)
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
