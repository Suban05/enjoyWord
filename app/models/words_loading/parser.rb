module WordsLoading
  class Parser
    def initialize(dictionary, words)
      @dictionary = dictionary
      @words = words
    end

    def parse
      languages = @dictionary.available_languages
      first_template = languages[:first_language].new.word_template
      second_template = languages[:second_language].new.word_template
      regex = /(.+?#{first_template}+.+?|#{first_template}+)\s*-\s*(.+#{second_template}+.+|#{second_template}+)/
      word_pairs = @words.scan(regex)
      word_pairs
    end
  end
end
