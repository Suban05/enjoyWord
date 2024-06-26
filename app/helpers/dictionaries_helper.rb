# frozen_string_literal: true

module DictionariesHelper
  def translation_types_display
    Dictionary.translation_types.keys.map { |type| [ friendly_translation_type(type), type ] }
  end

  def translation_type_display(dictionary)
    friendly_translation_type(dictionary.translation_type)
  end

  private

  def friendly_translation_type(translation_type)
    languages = translation_type.to_s.split("_").map do |s|
      s.capitalize
    end
    languages.join("-")
  end
end
