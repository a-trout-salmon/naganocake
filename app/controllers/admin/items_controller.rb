class Admin::ItemsController < Admin::ApplicationController

  # 商品一覧
  def index
    @items = Item.includes(:genre)
  end

  # 商品詳細
  def show
    @item = Item.find(params[:id])
  end

  # 新規登録画面
  def new
    @item = Item.new
  end

  # 新規登録処理
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集画面
  def edit
    @item = Item.find(params[:id])
  end

  # 更新処理
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # ストロングパラメータ
  def item_params
    params.require(:item).permit(
      :name,
      :introduction,
      :price,
      :genre_id,
      :is_active,
      :image
    )
  end
end