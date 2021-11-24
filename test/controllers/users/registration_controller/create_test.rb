require 'test_helper'

class Users::RegistrationsControllerCreateTest < ActionDispatch::IntegrationTest
  test "should respond with 400 when the user param is missing" do
    post users_registrations_url

    assert_response 400

    assert_equal(
      { "error" => "param is missing or the value is empty: user" },
      JSON.parse(response.body)
    )
  end

  test "should respond with 400 when the user email params are missing" do
    post users_registrations_url, params: { user: {} }

    assert_response 400

    assert_equal(
      { "error" => "param is missing or the value is empty: user" },
      JSON.parse(response.body)
    )
  end

  test "should respond with 422 when the user email is invalid" do
    post users_registrations_url, params: { user: { email: 'example'} }

    assert_response 422

    assert_equal(
      {
        "user" => {
          "email" => ["is invalid"]
        }
      },
      JSON.parse(response.body)
    )
  end

  test "should respond with 201 when creating the user" do
    assert_difference 'User.count', +1 do
      post users_registrations_url, params: { user: { email: 'example@email.com' } }
    end

    assert_response 201

    response_data = JSON.parse(response.body)
    user = response_data['user']

    assert_equal("example@email.com", user["email"])
    assert_kind_of(Numeric, user["id"])
  end
end
