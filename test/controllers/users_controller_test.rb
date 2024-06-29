# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @other_user = users(:jim)
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

  test "should get other user" do
    log_in_as(@user)
    get user_path(@other_user)
    assert_response :success
  end

  test "shouldn't get other user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_response :not_found
  end

  test "shouldn't edit other user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_response :not_found
  end
end
