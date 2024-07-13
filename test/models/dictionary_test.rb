# frozen_string_literal: true

require "test_helper"

class DictionaryTest < ActiveSupport::TestCase
  setup do
    @dictionary = dictionaries(:english_russian)
  end

  test "checks translation_types" do
    result = Dictionary.translation_types
    assert result.value?("chinese_english")
    assert result.value?("chinese_french")
    assert result.value?("chinese_german")
    assert result.value?("chinese_italian")
    assert result.value?("chinese_russian")
    assert result.value?("chinese_spanish")

    assert result.value?("english_chinese")
    assert result.value?("english_french")
    assert result.value?("english_german")
    assert result.value?("english_italian")
    assert result.value?("english_russian")
    assert result.value?("english_spanish")

    assert result.value?("french_chinese")
    assert result.value?("french_english")
    assert result.value?("french_german")
    assert result.value?("french_italian")
    assert result.value?("french_russian")
    assert result.value?("french_spanish")

    assert result.value?("german_chinese")
    assert result.value?("german_french")
    assert result.value?("german_italian")
    assert result.value?("german_russian")
    assert result.value?("french_russian")
    assert result.value?("german_spanish")

    assert result.value?("italian_chinese")
    assert result.value?("italian_english")
    assert result.value?("italian_french")
    assert result.value?("italian_german")
    assert result.value?("italian_russian")
    assert result.value?("italian_spanish")

    assert result.value?("russian_chinese")
    assert result.value?("russian_english")
    assert result.value?("russian_french")
    assert result.value?("russian_german")
    assert result.value?("russian_italian")
    assert result.value?("russian_spanish")

    assert result.value?("spanish_chinese")
    assert result.value?("spanish_english")
    assert result.value?("spanish_french")
    assert result.value?("spanish_german")
    assert result.value?("spanish_italian")
    assert result.value?("spanish_russian")
  end

  test "gets available languages of dictionary" do
    languages = @dictionary.available_languages
    assert_equal Dictionary::Languages::English, languages[:first_language]
    assert_equal Dictionary::Languages::Russian, languages[:second_language]
  end

  test "gets available external languages of dictionary" do
    languages = @dictionary.available_languages_audio
    assert_equal TheFreeDictionary::English, languages[:first_language]
    assert_equal TheFreeDictionary::Russian, languages[:second_language]
  end
end
