require 'test_helper'

class InvoicesControllerCreateTest < ActionDispatch::IntegrationTest
  test 'should respond with 401 if the user token is invalid' do
    post invoices_url

    assert_response 401
  end

  test 'should respond with 400 when the invoice params are missing' do
    user = users(:john_doe)

    post invoices_url, {
      headers: { 'Authorization' => "Bearer token=\"#{user.token}\"" },
      params: { number: 1 }
    }

    assert_response 400

    assert_equal(
      { 'invoice' => 'param is missing or the value is empty: invoice' },
      JSON.parse(response.body)
    )
  end

  test 'should respond with 201 when the invoice is created successfuly' do
    user = users(:john_doe)

    post invoices_url, {
      headers: { 'Authorization' => "Bearer token=\"#{user.token}\"" },
      params: { invoice: { number: 2, due_at: Time.current, bill_from: 'John Doe', bill_to: 'Another User', total: 200.00 } }
    }

    assert_response 201

    invoice_id = JSON.parse(response.body).dig('invoice', 'id')
    invoice = Invoice.find(invoice_id)

    assert_equal(
      { 'invoice' => invoice.as_json },
      JSON.parse(response.body)
    )
  end
end
