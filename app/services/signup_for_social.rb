class SignupForSocial
  attr_reader :user, :attrs

  def initialize(attrs)
    @attrs = attrs
    @user = case attrs[:social_type].to_i
    when 1 # 페이스북
      AuthenticationForFacebook.new(attrs.delete(:access_token)).call # email
    when 2 # 네이버
      AuthenticationForNaver.new(attrs.delete(:access_token)).call # email
    end
  end

  def call
    ActiveRecord::Base.transaction do

      rec_code = attrs.delete(:recommendation_code)

      user or raise ServiceError.new("사용자 정보를 받아올 수 없음", :forbidden)

      user.persisted? and raise ServiceError.new("이메일 중복", :conflict)

      user.attributes = attrs

      user.save or raise FailToSaveError.new(user)

      InvitationUser.new(rec_code).call(user) if rec_code.present?

      user
    end
  end
end
