# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview
  def send_token_via_email
    user = User.new(email: 'example@example.com', token: '12345')

    RegistrationMailer.with(user: user).send_token_via_email
  end
end
