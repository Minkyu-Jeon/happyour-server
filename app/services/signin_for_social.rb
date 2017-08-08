class SigninForSocial

  def call(social_type, access_token)
    case social_type.to_i
    when 1
      AuthenticationForFacebook.new(access_token).call
    when 2
      AuthenticationForNaver.new(access_token).call
    end
  end
end
