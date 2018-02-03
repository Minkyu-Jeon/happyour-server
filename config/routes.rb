Rails.application.routes.draw do
  if Rails.application.secrets["server_mode"] == "api"
    namespace :v1 do
    	post 'user/signup' => 'users#social_signup' # 회원가입
    	post 'login' => 'users#social_login' # 로그인
      get 'stores' => 'stores#index' # 가맹점 목록
      get 'stores/:id' => 'stores#show' # 가맹점 상세보기
      get 'menus/:id' => 'menus#show' # 메뉴 상세보기
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
