# frozen_string_literal: true

module Dictionary::Lingual
  extend ActiveSupport::Concern
  include Dictionary::Languages

  included do
    validates :name, :translation_type, presence: true
    enum translation_type: translation_types
  end

  def available_languages
    Dictionary::TranslationType.new(translation_type).pairs
  end

  def available_languages_audio
    Dictionary::TranslationType.new(translation_type).pairs(Dictionary.external)
  end

  class_methods do
    def external
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

    private

    def translation_types
      languages = Language.available.keys
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
