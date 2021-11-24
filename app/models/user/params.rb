class User::Params
  def self.to_register(params)
    params.require(:user).permit(:email).tap do |user_params|
      user_params.require(:email)
    end
  end
end
