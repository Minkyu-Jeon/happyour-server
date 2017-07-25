class InvitationUser
  def initialize(code)
    @code = code
  end

  def call(user)
    rec_user = find_user(code)
    rec_user.present? or return false

    rec_user.invitations.create!({email: user.email, invited_user_id: user.id})
  end

  private
  attr_reader :code
  def find_user
    u = User.find_by_recommendation_code(code)
    u
  end
end
