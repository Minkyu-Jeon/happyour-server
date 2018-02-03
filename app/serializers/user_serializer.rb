class UserSerializer < ApplicationSerializer
	attributes :id, :email, :nickname, :social_type, :created_at, :updated_at
end
