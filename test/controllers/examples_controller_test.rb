# frozen_string_literal: true

require "test_helper"

class ExamplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @example = examples(:one)
    @word = words(:one)
  end

  test "should get index" do
    log_in_as(@user)
    get examples_path(word_id: @word.id)
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_example_path(word_id: @word.id)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_example_path(@example)
    assert_response :success
  end

  test "should get show" do
    log_in_as(@user)
    get example_path(@example)
    assert_response :success
  end
end
