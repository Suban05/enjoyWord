# frozen_string_literal: true

module Dictionary::Languages
  class Russian < Language
    def word_template
      /[а-яА-Я]+/
    end

    def name
      I18n.t("dictionary.languages.russian")
    end
  end
end
