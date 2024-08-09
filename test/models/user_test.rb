# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "calls favourite_language_as_object when favourite_language is empty" do
    user = users(:john)
    result = user.favourite_language_as_object
    assert_equal Dictionary::Language, result.class
  end

  test "calls favourite_language_as_object when favourite_language is present" do
    user = users(:jim)
    result = user.favourite_language_as_object
    assert_equal Dictionary::Languages::English, result.class
  end
end
