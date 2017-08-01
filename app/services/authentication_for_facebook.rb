class AuthenticationForFacebook
  def initialize(access_token)
    @url = "https://graph.facebook.com"
    @access_token = access_token
  end

  def call
    conn = Faraday.new(url: url)

    response = conn.get do |req|
      req.url '/v2.5/me'
      req.params["access_token"] = access_token
      req.params["fields"] = "email"
    end

    begin
      if response.status == 200
        resp = JSON.parse(response.body)
        user = User.find_or_initialize_by(email: resp["email"])
        return user if user.persisted?
        user.attributes = user_params(resp)
        user
      else
        false
      end
    rescue => e
      Rails.logger.info e.message
      raise SocialProfileError, "사용자 정보 요청 혹은 응답 처리 에러"
    end
  end

  private
  attr_reader :url, :access_token
  def user_params(resp)
    {
      email: resp["email"],
      password: SecureRandom.hex(16)
    }
  end
end
