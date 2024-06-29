module WordsLoading
  class Loading
    def initialize(**args)
      @dictionary = args[:dictionary]
      @words = args[:words]
    end

    def call
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
