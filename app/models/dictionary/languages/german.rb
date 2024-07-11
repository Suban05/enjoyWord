# frozen_string_literal: true

module Dictionary::Languages
  class German < Language
    def word_template
      /[a-zA-ZäöüßÄÖÜ]+/
    end

    def name
      I18n.t("dictionary.languages.german")
    end
  end
end
