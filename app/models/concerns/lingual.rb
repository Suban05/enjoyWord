module Lingual
  extend ActiveSupport::Concern

  included do
    validates :name, :translation_type, presence: true
    enum translation_type: translation_types
  end

  def available_languages
    languages = self.translation_type.to_s.split('_')
    {
      first_language: Dictionary.language_mappings[languages.first.to_sym],
      second_language: Dictionary.language_mappings[languages.second.to_sym]
    }
  end

  class_methods do
    # @param words [String]
    def write_words(dictionary, words)
      languages = dictionary.available_languages
      first_template = languages[:first_language].word_template
      second_template = languages[:second_language].word_template
      regex = /(.+?#{first_template}.+?)\s*-\s*(.+#{second_template}.+)/
      word_pairs = words.scan(regex)
      result = []
      word_pairs.each do |pair|
        word = dictionary.words.build(content: pair.first.strip, translation: pair.second.strip)
        if word.save
          result << word
        end
      end
      result
    end

    def language_mappings
      {
        english: Languages::English,
        russian: Languages::Russian,
        spanish: Languages::Spanish,
      }
    end

    private

    def translation_types
      languages = language_mappings.keys
      types = []
      languages.each do |first|
        languages.each do |second|
          next if first == second

          types << "#{first}_#{second}".to_sym
        end
      end
      types
    end
  end
end
