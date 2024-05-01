require "test_helper"

class LearningSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @dictionary = dictionaries(:english_russian)
  end

  test "should get new" do
    log_in_as(@user)
    get learning_sessions_new_path(dictionary_id: @dictionary)
    assert_response :success
  end

  test "should get create" do
    get learning_sessions_create_url
    assert_response :success
  end
end
