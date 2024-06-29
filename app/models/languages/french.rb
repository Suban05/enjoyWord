# frozen_string_literal: true

module Languages
  class French < Language
    def word_template
      /[a-zA-ZàâçéèêëîïôûùüÿñæœÀÂÇÉÈÊËÎÏÔÛÙÜŸÑÆŒ]+/
    end
  end
end
