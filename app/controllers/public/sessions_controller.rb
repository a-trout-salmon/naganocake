class Public::SessionsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

    def new
    end

    def create
      customer = Customer.find_by(email_address: params[:email_address])

      if customer&.authenticate(params[:password])
        session[:customer_id] = customer.id
        redirect_to items_path, notice: "ログインしました。"
      else
        flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
        @email_address = params[:email_address]
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete(:customer_id)
      redirect_to root_path, notice: "ログアウトしました。"
    end
end
