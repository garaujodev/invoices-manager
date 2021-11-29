require 'test_helper'

class InvoicesControllerIndexTest < ActionDispatch::IntegrationTest
  test 'should respond with 401 if the user token is invalid' do
    get invoices_url

    assert_response 401
  end

  test 'should respond with 200 when the user has not invoices' do
    user = users(:another_user)

    get invoices_url, headers: { 'Authorization' => "Bearer token=\"#{user.token}\"" }

    assert_response 200

    assert_equal({ 'invoices' => [] }, JSON.parse(response.body))
  end

  test 'should respond with 200 when the user has invoices' do
    user = users(:john_doe)

    get invoices_url, headers: { 'Authorization' => "Bearer token=\"#{user.token}\"" }

    assert_response 200

    invoices = JSON.parse(response.body)['invoices']

    assert_equal 1, invoices.size
    assert_equal 1, invoices.first['number']
    assert_equal 'John Doe', invoices.first['bill_from']
    assert_equal '1500.0', invoices.first['total']
  end
end
