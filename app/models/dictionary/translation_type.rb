# frozen_string_literal: true

class Dictionary::TranslationType
  attr_reader :translation_type

  def initialize(translation_type)
    @translation_type = translation_type
  end

  def to_a
    @translation_type.to_s.split("_")
  end

  def pairs(mappings = Dictionary::Language.available)
    languages = to_a
    {
      first_language: mappings[languages.first.to_sym],
      second_language: mappings[languages.second.to_sym]
    }
  end

  def friendly
    languages = to_a.map do |language_id|
      language = Dictionary::Language.find_by_id(language_id.to_sym)
      language_id = language.new.name.capitalize
    end
    languages.join("-")
  end
end
