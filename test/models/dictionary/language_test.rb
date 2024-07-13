# frozen_string_literal: true

require "test_helper"

class DictionaryLanguageTest < ActiveSupport::TestCase
  test "gets language class by id" do
    result = Dictionary::Language.find_by_id(:english)
    assert_equal Dictionary::Languages::English, result

    result = Dictionary::Language.find_by_id(:chinese)
    assert_equal Dictionary::Languages::Chinese, result

    result = Dictionary::Language.find_by_id(:russian)
    assert_equal Dictionary::Languages::Russian, result

    result = Dictionary::Language.find_by_id(:spanish)
    assert_equal Dictionary::Languages::Spanish, result

    result = Dictionary::Language.find_by_id(:german)
    assert_equal Dictionary::Languages::German, result

    result = Dictionary::Language.find_by_id(:italian)
    assert_equal Dictionary::Languages::Italian, result

    result = Dictionary::Language.find_by_id(:french)
    assert_equal Dictionary::Languages::French, result
  end

  test "doesn't get language class by id" do
    result = Dictionary::Language.find_by_id(:test)
    assert_equal Dictionary::Languages::Language, result
  end
end
