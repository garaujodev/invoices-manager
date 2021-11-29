require 'test_helper'

class InvoicesControllerEmailTest < ActionDispatch::IntegrationTest
  test 'should respond with 401 if the user token is invalid' do
    post invoices_url

    assert_response 401
  end

  test 'should respond with 404 when the invoice not exists' do
    user = users(:john_doe)

    invoice = invoices(:first)

    post invoice_email_url(invoice.id), {
      headers: { 'Authorization' => "Bearer token=\"#{user.token}\"" },
      params: { emails: ['email@example.com'] }
    }

    assert_response 201

    assert_equal(
      { 'emails' => 'Emails was recorded successfully' },
      JSON.parse(response.body)
    )

    assert_equal 1, invoice.emails.count
  end
end
