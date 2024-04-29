require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
  end

  test "should get home" do
    log_in_as(@user)
    get home_path
    assert_response :success
  end
end
