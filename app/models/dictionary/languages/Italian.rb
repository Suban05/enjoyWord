# frozen_string_literal: true

module Dictionary::Languages
  class Italian < Language
    def word_template
      /[a-zA-ZàèéìíîòóùúÀÈÉÌÍÎÒÓÙÚ]+/
    end

    def name
      I18n.t("dictionary.languages.italian")
    end
  end
end
