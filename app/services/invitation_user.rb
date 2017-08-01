class InvitationUser
  def initialize(code)
    @code = code
  end

  def call(user)
    begin
      rec_user = find_user(code)
      rec_user.present? or return false

      i = rec_user.invitations.create!({email: user.email, invited_user_id: user.id})
      free_subscription = Subscription.find_by(type: 0)

      invitation_len = rec_user.invitations.length
      users = [user, rec_user]
      users.delete_at(1) if invitation_len > INVITATION_LIMIT

      users.each do |u|
        expired_at = u.subscription_users.order(expired_at: :desc).first.try(:expired_at) || Time.current
        expired_at += free_subscription.days.day
        u.subscription_users.create!({
          subscription_id: free_subscription.id,
          expired_at: expired_at,
          invitation_id: i.id
        })

      end
    rescue Exception => e
      false
    end
  end

  private
  attr_reader :code
  def find_user
    User.find_by_recommendation_code(code)
  end
end
