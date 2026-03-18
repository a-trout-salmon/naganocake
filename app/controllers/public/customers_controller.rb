class Public::CustomersController < Public::ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer

    if @customer.update(customer_params)
      redirect_to customers_my_page_path, notice: "会員情報が更新されました。"
    else
      flash.now[:alert] = "会員情報の更新に失敗しました。入力内容をご確認ください。"
      render :edit, status: :unprocessable_entity
    end
  end

  def unsubscribe
  end

  def withdraw
    if current_customer.update(is_active: false)
      terminate_session
      redirect_to root_path, notice: "ご利用ありがとうございました。またのご利用をお待ちしております。"
    else
      redirect_to unsubscribe_customers_path, alert: "退会処理に失敗しました。時間をおいて再度お試しください。"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :email_address,
      :postal_code,
      :address,
      :telephone_number,
      :password,
      :password_confirmation
    )
  end
end
