class SigninForSocial

  def call(social_type, access_token)
    user = case social_type.to_i
    when 1
      AuthenticationForFacebook.new(access_token).call
    when 2
      AuthenticationForNaver.new(access_token).call
    end

    user.social_type != social_type.to_i and raise ServiceError.new("이메일 중복", :conflict)

    user.save unless user.present? # 미가입이면 가입
  end
end
