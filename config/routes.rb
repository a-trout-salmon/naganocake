Rails.application.routes.draw do
  # -------------------------
  # Public
  # -------------------------
  scope module: :public do
    root "homes#top"
    get "/about", to: "homes#about"


    # 商品
    resources :items, only: [:index, :show]

    # 顧客会員登録
    get  "/customers/sign_up", to: "registrations#new",    as: :new_customer_registration
    post "/customers",         to: "registrations#create", as: :customer_registration

    # 顧客ログイン / ログアウト
    get    "/customers/sign_in",  to: "sessions#new",     as: :new_customer_session
    post   "/customers/sign_in",  to: "sessions#create",  as: :customer_session
    delete "/customers/sign_out", to: "sessions#destroy", as: :destroy_customer_session

    # 顧客マイページ関連
    get   "/customers/my_page",          to: "customers#show",        as: :customers_my_page
    get   "/customers/information/edit", to: "customers#edit",        as: :edit_customers_information
    patch "/customers/information",      to: "customers#update",      as: :customers_information
    get   "/customers/unsubscribe",      to: "customers#unsubscribe", as: :unsubscribe_customers
    patch "/customers/withdraw",         to: "customers#withdraw",    as: :withdraw_customers


    # カート
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    # 注文
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post :confirm
        get  :complete
      end
    end

    # 配送先
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  # -------------------------
  # Admin
  # -------------------------
  namespace :admin do
    # 管理者ログイン / ログアウト
    get    "/sign_in",  to: "sessions#new",     as: :new_session
    post   "/sign_in",  to: "sessions#create",  as: :session
    delete "/sign_out", to: "sessions#destroy", as: :destroy_session

    # 管理者トップ
    root "homes#top"

    # 商品
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    # ジャンル
    resources :genres, only: [:index, :create, :edit, :update]

    # 顧客
    resources :customers, only: [:index, :show, :edit, :update]

    # 注文
    resources :orders, only: [:index, :show, :update]

    # 注文詳細（製作ステータス更新）
    resources :order_details, only: [:update]
  end
end
