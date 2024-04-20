module DictionaryWritable
  extend ActiveSupport::Concern

  included do
    validates :name, :translation_type, presence: true
    enum translation_type: translation_types
  end

  class_methods do
    # @param words [String]
    def write_words(dictionary, words)
      languages = dictionary.translation_type.to_s.split('_')
      first_language = language_mappings[languages.first.to_sym]
      second_language = language_mappings[languages.second.to_sym]
      regex = /(.+?#{first_language.word_template}.+?)\s*-\s*(.+#{second_language.word_template}.+)/
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

    def language_mappings
      {
        english: English,
        russian: Russian,
        spanish: Spanish,
      }
    end
  end
end
