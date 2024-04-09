require "test_helper"

class DictionariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dictionaries_index_url
    assert_response :success
  end

  test "should get new" do
    get dictionaries_new_url
    assert_response :success
  end

  test "should get create" do
    get dictionaries_create_url
    assert_response :success
  end

  test "should get edit" do
    get dictionaries_edit_url
    assert_response :success
  end

  test "should get update" do
    get dictionaries_update_url
    assert_response :success
  end

  test "should get show" do
    get dictionaries_show_url
    assert_response :success
  end

  test "should get destroy" do
    get dictionaries_destroy_url
    assert_response :success
  end
end
