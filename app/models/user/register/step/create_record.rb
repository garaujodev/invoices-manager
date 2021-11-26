class User::Register::Step::CreateRecord < Micro::Case
  attribute :email

  def call!
    user = User.find_or_initialize_by(email: email)
    user.update(user_attributes)

    return Success result: { user: user } if user.persisted?

    Failure :invalid_user_params, result: { errors: user.errors.as_json }
  end

  private

  def user_attributes
    { email: email, token: SecureRandom.uuid }
  end
end
