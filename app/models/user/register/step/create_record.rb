class User::Register::Step::CreateRecord < Micro::Case
  attribute :email

  def call!
    user = User.new(user_attributes).tap(&:save)

    return Success result: { user: user } if user.persisted?

    Failure :invalid_user_params, result: { errors: user.errors.as_json }
  end

  private

  def user_attributes
    { email: email, token: SecureRandom.uuid }
  end
end
