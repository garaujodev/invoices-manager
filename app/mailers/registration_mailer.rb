class RegistrationMailer < ApplicationMailer
  def send_token_via_email
    @user = params[:user]

    mail(to: @user.email, subject: 'Registration confirmation')
  end
end
