Rails.application.routes.draw do
  namespace :v1 do
  	# 회원가입
  	post 'user/signup' => 'users#create'
  	post 'user/social_signup' => 'users#social_signup'

  	# 로그인
  	post 'login' => 'users#login'
  	post 'social_login' => 'users#social_login'

    # 가맹점
    get 'stores' => 'stores#index' # 가맹점 목록
    get 'stores/:id' => 'stores#show' # 가맹점 상세보기

    # 메뉴
    get 'menus/:id' => 'menus#show' # 메뉴 상세보기

    # 주문
    post 'orders' => 'orders#create' # 주문하기
    put 'orders/:id' => 'orders#update' # 수령하기
    post 'order_histories' => 'order_histories#create' # 평가하기
  end
end
