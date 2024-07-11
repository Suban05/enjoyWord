# frozen_string_literal: true

module Dictionary::Languages
  class Spanish < Language
    def word_template
      /[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]+/
    end

    def name
      I18n.t("dictionary.languages.spanish")
    end
  end
end
