class LoginSerializer < TokenSerializer
  belongs_to :user

  def user
    object.user
  end
end
