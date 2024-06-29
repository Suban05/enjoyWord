# frozen_string_literal: true

module Languages
  class English < Language
    def word_template
      /[a-zA-Z]+/
    end
  end
end
