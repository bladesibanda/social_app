require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: @user.email + "a", name: @user.name,
                                       password: "secret", password_confirmation: "secret" } },
                      as: :json
    end

    assert_response :created
  end

  test "should show user" do
    get user_url(@user), as: :json, headers: auth_headers(@user.email, @user.password)
    assert_response :success
  end

  test "should not show user if unauthenticated" do
    get user_url(@user), as: :json
    assert_response :unauthorized
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, name: @user.name,
                                            password: "secret", password_confirmation: "secret" } },
                           as: :json,
                           headers: auth_headers(@user.email, @user.password)
    assert_response :success
  end

  test "should not update user if unauthenticated" do
    patch user_url(@user), params: { user: { email: @user.email, name: @user.name,
                                            password: "secret", password_confirmation: "secret" } },
                           as: :json
    assert_response :unauthorized
  end

  test "should not update user if not owner" do
    user2 = create :user
    patch user_url(@user), params: { user: { email: @user.email, name: @user.name,
                                            password: "secret", password_confirmation: "secret" } },
                           as: :json, headers: auth_headers(user2.email, user2.password)
    assert_response :forbidden
  end

  test "should update user partially" do
    patch user_url(@user), params: { user: { email: @user.email, name: "New Name" } }, as: :json,
                           headers: auth_headers(@user.email, @user.password)
    assert_response :success
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user), as: :json, headers: auth_headers(@user.email, @user.password)
    end

    assert_response :no_content
  end

  test "should not destroy user if not owner" do
    user2 = create :user
    assert_difference("User.count", 0) do
      delete user_url(@user), as: :json, headers: auth_headers(user2.email, user2.password)
    end

    assert_response :forbidden
  end

  test "should not destroy user if unauthenticated" do
    assert_difference("User.count", 0) do
      delete user_url(@user), as: :json
    end

    assert_response :unauthorized
  end
end
