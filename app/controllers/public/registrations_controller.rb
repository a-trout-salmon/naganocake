class Public::RegistrationsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[new create]

    def new
      @customer = Customer.new
    end

    def create
      @customer = Customer.new(customer_params)

      if @customer.save
        session[:customer_id] = @customer.id
        redirect_to customers_my_page_path, notice: "会員登録が完了しました。"
      else
        flash.now[:alert] = "会員登録に失敗しました。入力内容をご確認ください。"
        render :new, status: :unprocessable_entity
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
