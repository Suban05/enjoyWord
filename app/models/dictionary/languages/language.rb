# frozen_string_literal: true

module Dictionary::Languages
  class Language
    attr_accessor :external_dictionary

    def self.find_by_id(id)
      available[id] || Language
    end

    def self.available
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

    def initialize(external_dictionary = nil)
      @external_dictionary = external_dictionary
    end

    def external_data(word)
      @external_dictionary.find(word.content)
    end

    def word_of_day
      begin
        @external_dictionary.word_of_day
      rescue
        { sound: '', transcription: '', word: '' }
      end
    end

    def name
      ""
    end
  end
end
