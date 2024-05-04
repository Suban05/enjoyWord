module Lingual
  extend ActiveSupport::Concern
  include TheFreeDictionary

  included do
    validates :name, :translation_type, presence: true
    enum translation_type: translation_types
  end

  # @param words [String]
  def write_words(words)
    languages = self.available_languages
    first_template = languages[:first_language].new.word_template
    second_template = languages[:second_language].new.word_template
    regex = /(.+?#{first_template}.+?)\s*-\s*(.+#{second_template}.+)/
    word_pairs = words.scan(regex)
    result = []
    word_pairs.each do |pair|
      word = self.words.build(content: pair.first.strip, translation: pair.second.strip)
      if word.save
        result << word
      end
    end
    result
  end

  def available_languages
    available_languages_data(self.class.language_mappings)
  end

  def available_languages_audio
    available_languages_data(self.class.language_audio_mappings)
  end

  private

  def available_languages_data(mappings)
    languages = self.translation_type.to_s.split('_')
    {
      first_language: mappings[languages.first.to_sym],
      second_language: mappings[languages.second.to_sym]
    }
  end

  class_methods do
    def language_mappings
      {
        english: Languages::English,
        russian: Languages::Russian,
        spanish: Languages::Spanish,
      }
    end

    def language_audio_mappings
      {
        english: EnglishAudio,
        russian: NoneAudio,
        spanish: SpanishAudio,
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
