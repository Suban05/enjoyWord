# frozen_string_literal: true

module DictionariesHelper
  def translation_types_display
    Dictionary.translation_types.keys.map { |type| [ friendly_translation_type(type), type ] }
  end

  def translation_type_display(dictionary)
    friendly_translation_type(dictionary.translation_type)
  end

  def words_count(dictionary)
    t("dictionary.words_total", count: dictionary.words.count)
  end

  private

  def friendly_translation_type(translation_type)
    Dictionary::TranslationType.new(translation_type).friendly
  end
end
