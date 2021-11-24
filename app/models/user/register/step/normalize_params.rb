require 'u-case/with_activemodel_validation'

class User::Register::Step::NormalizeParams < Micro::Case
  attribute :params

  validates! :params, kind: ActionController::Parameters

  def call!
    user_params = User::Params.to_register(params)

    return Success result: { email: user_params[:email] }
  rescue ActionController::ParameterMissing => e
    Failure :parameter_missing, result: { message: e.message }
  end
end
