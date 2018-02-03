class UserSerializer < ApplicationSerializer
	attributes :id, :loginid, :email, :nickname, :social_type, :created_at, :updated_at
end
