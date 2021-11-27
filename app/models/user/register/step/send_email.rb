class User::Register::Step::SendEmail < Micro::Case
  attribute :user

  validates! :user, kind: User

  def call!
    RegistrationMailer.with(user: user).send_token_via_email.deliver_now

    Success result: { user: user }
  end
end
