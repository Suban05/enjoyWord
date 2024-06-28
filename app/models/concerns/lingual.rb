module Lingual
  extend ActiveSupport::Concern
  include TheFreeDictionary

  included do
    validates :name, :translation_type, presence: true
    enum translation_type: translation_types
  end

  # @param words [String]
  def write_words(words)
    WordsLoading::Loader.new(self, WordsLoading::Parser.new(self, words).parse).load
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
        german:  Languages::German,
        italian: Languages::Italian,
        french:  Languages::French
      }
    end

    def language_audio_mappings
      {
        english: EnglishAudio,
        russian: NoneAudio,
        spanish: SpanishAudio,
        german:  GermanAudio,
        italian: ItalianAudio,
        french: FrenchAudio
      }
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
      types
    end
  end
end
