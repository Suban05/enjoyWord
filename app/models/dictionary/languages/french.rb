# frozen_string_literal: true

module Dictionary::Languages
  class French < Language
    def word_template
      /[a-zA-ZàâçéèêëîïôûùüÿñæœÀÂÇÉÈÊËÎÏÔÛÙÜŸÑÆŒ]+/
    end

    def name
      I18n.t("dictionary.languages.french")
    end
  end
end
