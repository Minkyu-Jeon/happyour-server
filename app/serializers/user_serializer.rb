class UserSerializer < ApplicationSerializer
	attributes :id, :loginid, :email, :nickname, :social_type
end
