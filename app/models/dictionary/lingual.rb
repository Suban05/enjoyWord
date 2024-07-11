# frozen_string_literal: true

module Dictionary::Lingual
  extend ActiveSupport::Concern
  include Dictionary::Languages

  included do
    validates :name, :translation_type, presence: true
    enum translation_type: translation_types
  end

  def available_languages
    available_languages_data(self.class.language_mappings)
  end

  def available_languages_audio
    available_languages_data(self.class.language_audio_mappings)
  end

  private

  def available_languages_data(mappings)
    languages = self.translation_type.to_s.split("_")
    {
      first_language: mappings[languages.first.to_sym],
      second_language: mappings[languages.second.to_sym]
    }
  end

  class_methods do
    def language_mappings
      {
        english: English,
        russian: Russian,
        spanish: Spanish,
        german:  German,
        italian: Italian,
        french:  French,
        chinese: Chinese
      }
    end

    def language_audio_mappings
      {
        english: TheFreeDictionary::English,
        russian: TheFreeDictionary::Russian,
        spanish: TheFreeDictionary::Spanish,
        german:  TheFreeDictionary::German,
        italian: TheFreeDictionary::Italian,
        french:  TheFreeDictionary::French,
        chinese: TheFreeDictionary::Chinese
      }
    end

    def language_by_id(id)
      language_mappings[id] || Language
    end

    private

    def translation_types
      languages = language_mappings.keys
      types = {}
      languages.each do |first|
        languages.each do |second|
          next if first == second

          first_second_lang = "#{first}_#{second}"
          types[first_second_lang.to_sym] = first_second_lang
        end
      end
      types.sort.to_h
    end
  end
end
