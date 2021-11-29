require 'test_helper'

class InvoicesControllerShowTest < ActionDispatch::IntegrationTest
  test 'should respond with 401 if the user token is invalid' do
    get invoices_url(id: 1)

    assert_response 401
  end

  test 'should respond with 404 when the invoice not exists' do
    user = users(:john_doe)

    get invoice_url(-1), {
      headers: { 'Authorization' => "Bearer token=\"#{user.token}\"" }
    }

    assert_response 404

    assert_equal(
      { 'invoice' => 'Invoice not found' },
      JSON.parse(response.body)
    )
  end
end
