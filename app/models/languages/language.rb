# frozen_string_literal: true

module Languages
  class Language
    attr_accessor :pronunciation_lib

    def initialize(pronunciation_lib = nil)
      @pronunciation_lib = pronunciation_lib
    end

    def find(word)
      @pronunciation_lib.find(word.content)
    end
  end
end
