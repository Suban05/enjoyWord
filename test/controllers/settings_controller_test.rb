require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
  end

  test "should get new" do
    log_in_as(@user)
    get new_setting_path
    assert_response :success
  end

  test "changes user fields" do
    log_in_as(@user)
    assert_nil @user.favourite_language
    post settings_path params: { email: @user.email, name: @user.name, favourite_language: 'spanish' }
    assert_redirected_to root_path
    @user.reload
    assert_equal 'spanish', @user.favourite_language
  end
end
