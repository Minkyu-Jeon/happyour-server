Rails.application.routes.draw do
  namespace :v1 do
  	# 회원가입
  	post 'user/signup' => 'users#create'
  	post 'user/social_signup' => 'users#social_signup'

  	# 로그인
  	post 'login' => 'users#login'
  	post 'social_login' => 'users#social_login'
  end
end
