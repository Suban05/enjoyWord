module Languages
  class Language
    attr_accessor :pronunciation_lib

    def initialize(pronunciation_lib = nil)
      @pronunciation_lib = pronunciation_lib
    end

    def pronunciation(word)
      @pronunciation_lib.pronunciation(word.content)
    end
  end
end
