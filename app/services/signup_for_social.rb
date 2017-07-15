class SignupForSocial
  attr_reader :social_email, :attrs

  def initialize(attrs)
    @attrs = attrs
    @social_email = case attrs[:social_type]
    when 1 # 페이스북
      AuthenticationForFacebook.new(attrs.delete(:access_token)).call # email
    when 2 # 네이버
      AuthenticationForNaver.new(attrs.delete(:access_token)).call # email
    end
  end

  def call
    user = User.find_or_initialize_by(email: social_email)

    user.persisted? and raise ServiceError.new("이메일 중복", :conflict)

    user.attributes = attrs

    user.save or raise FailToSaveError.new(user)

    user
  end
end
