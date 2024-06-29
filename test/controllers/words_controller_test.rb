# frozen_string_literal: true

require "test_helper"

class WordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @word = words(:one)
    @dict = dictionaries(:english_spanish)
  end

  test "should get index" do
    log_in_as(@user)
    get words_path(dictionary_id: @dict.id)
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_word_path(dictionary_id: @dict.id)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_word_path(@word)
    assert_response :success
  end

  test "should get show" do
    log_in_as(@user)
    get word_path(@word)
    assert_response :success
  end
end
