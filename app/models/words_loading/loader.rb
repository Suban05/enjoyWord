module WordsLoading
  class Loader
    def initialize(dictionary, words)
      @dictionary = dictionary
      @words = words
    end

    def load
      result = []
      @words.each do |pair|
        word = @dictionary.words.build(content: pair.first.strip, translation: pair.second.strip)
        if word.save
          result << word
        end
      end
      result
    end
  end
end
