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

    def find(word)
      @external_dictionary.find(word.content)
    end

    def name
      ""
    end
  end
end
