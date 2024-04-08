require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
  end

  test "should redirect to login" do
    get users_url
    assert_redirected_to login_path
  end

  test "should get index" do
    log_in_as(@user)
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end
end
