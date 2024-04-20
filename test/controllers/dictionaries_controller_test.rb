require "test_helper"

class DictionariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @dict = dictionaries(:english_spanish)
  end

  test "should get index" do
    log_in_as(@user)
    get dictionaries_path
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_dictionary_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_dictionary_path(@dict)
    assert_response :success
  end

  test "should get show" do
    log_in_as(@user)
    get dictionary_path(@dict)
    assert_response :success
  end
end
