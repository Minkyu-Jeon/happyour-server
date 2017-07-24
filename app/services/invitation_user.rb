class InvitationUser
  def initialize(code)
    @code = code
  end

  def call(user)
    rec_user = find_user(code)
    rec_user.present? or return false

    rec_user.invitations.create!({email: user.email, invited_user_id: user.id})

    t.integer  "user_id",            null: false
    t.integer  "invitation_user_id"
    t.datetime "expired_at",         null: false
    [user, rec_user].each_with_index do |u, index|
      expired_at = u.vouchers.order(expired_at: :desc).first.try(:expired_at) || Time.current
      exp_at = expired_at + 1.month
      u.vouchers.create({})
    end
  end

  private
  attr_reader :code
  def find_user
    u = User.find_by_recommendation_code(code)
    u
  end
end
