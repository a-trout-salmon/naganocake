class Public::SessionsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_customer_session_url, alert: "Try again later." }

  def new
    redirect_to items_path if authenticated_customer?
  end

  def create
    customer = Customer.find_by(email_address: params[:email_address])

    if customer&.authenticate(params[:password])
      if customer.is_active?
        start_new_session_for(customer)
        redirect_to items_path, notice: "ログインしました。"
      else
        flash.now[:alert] = "退会済みのためログインできません。"
        @email_address = params[:email_address]
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      @email_address = params[:email_address]
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "ログアウトしました。"
  end
end
