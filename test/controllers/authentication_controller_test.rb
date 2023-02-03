require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user, email: "blessed@example", password: "secret"
  end

  test "should login with valid credentials" do
    post auth_login_url, params: { email: @user.email, password: "secret" }
    assert_response :success
    assert_not_nil json_response["token"]
  end

  test "should not login with invalid credentials" do
    post auth_login_url, params: { email: @user.email, password: "wrong" }
    assert_response :unauthorized
    assert_nil json_response["token"]
  end
end
