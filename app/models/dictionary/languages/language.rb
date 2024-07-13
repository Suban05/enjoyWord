# frozen_string_literal: true

module Dictionary::Languages
  class Language
    attr_accessor :pronunciation_lib

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

    def self.external
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

    def initialize(pronunciation_lib = nil)
      @pronunciation_lib = pronunciation_lib
    end

    def find(word)
      @pronunciation_lib.find(word.content)
    end

    def name
      ""
    end
  end
end
