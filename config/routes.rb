Rails.application.routes.draw do
  if Rails.application.secrets["server_mode"] == "api"
    namespace :v1 do
    	# 회원가입
    	post 'user/signup' => 'users#social_signup'

    	# 로그인
    	post 'login' => 'users#social_login'

      # 가맹점
      get 'stores' => 'stores#index' # 가맹점 목록
      get 'stores/:id' => 'stores#show' # 가맹점 상세보기

      # 메뉴
      get 'menus/:id' => 'menus#show' # 메뉴 상세보기

      # 주문
      # post 'orders' => 'orders#create' # 주문하기
      # put 'orders/:id' => 'orders#update' # 수령하기
      # 리뷰 작성
      post 'reviews' => 'reviews#create' # 평가하기
    end
  elsif Rails.application.secrets["server_mode"] == "admin"
    scope module: :admin do
      root to: "users#index"
      resources :users
      resources :stores do
        resources :menus
        resources :orders
      end

      get "/login" => "sessions#new"
      post "/login" => "sessions#create"
      delete "/logout" => "sessions#destroy"
    end
  end
end
