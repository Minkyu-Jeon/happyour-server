class UserSerializer < ApplicationSerializer
	attributes :id, :email, :nickname, :recommendation_code, :social_type, :created_at, :updated_at
end
