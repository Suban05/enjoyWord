# frozen_string_literal: true

require "test_helper"

class DictionaryTranslationTypeTest < ActiveSupport::TestCase
  setup do
    @dictionary = dictionaries(:english_spanish)
  end

  test "creates instance of translation type" do
    translation_type = Dictionary::TranslationType.new(@dictionary.translation_type)
    assert translation_type.instance_of?(Dictionary::TranslationType)
  end

  test "converts to array" do
    translation_type = Dictionary::TranslationType.new(@dictionary.translation_type)
    result = translation_type.to_a
    assert_equal "english", result.first
    assert_equal "spanish", result.second
  end

  test "gets pairs from default mappings" do
    translation_type = Dictionary::TranslationType.new(@dictionary.translation_type)
    result = translation_type.pairs
    assert_equal Dictionary::Languages::English, result[:first_language]
    assert_equal Dictionary::Languages::Spanish, result[:second_language]
  end

  test "gets pairs from external mappings" do
    translation_type = Dictionary::TranslationType.new(@dictionary.translation_type)
    result = translation_type.pairs({ english: "English", spanish: "Spanish" })
    assert_equal "English", result[:first_language]
    assert_equal "Spanish", result[:second_language]
  end

  test "gets friendly view of translation_type" do
    result = Dictionary::TranslationType.new(@dictionary.translation_type).friendly
    assert_equal "English-Spanish", result
  end
end
