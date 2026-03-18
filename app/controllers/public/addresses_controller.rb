class Public::AddressesController < Public::ApplicationController

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.new(address_params)

    if @address.save
      redirect_to addresses_path, notice: "新しいお届け先を登録しました。"
    else
      @addresses = current_customer.addresses.reload
      flash.now[:alert] = "お届け先の登録に失敗しました。入力内容を確認してください。"
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path, notice: "お届け先を更新しました。"
    else
      flash.now[:alert] = "お届け先の更新に失敗しました。入力内容を確認してください。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    address = current_customer.addresses.find(params[:id])
    address.destroy
    redirect_to addresses_path, notice: "お届け先を削除しました。"
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
