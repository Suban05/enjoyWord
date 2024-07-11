# frozen_string_literal: true

module Dictionary::Languages
  class Chinese < Language
    def word_template
      /[\u4e00-\u9fff\u3400-\u4DBF\u20000-\u2A6DF\u2A700-\u2B73F\u2B740-\u2B81F\u2B820-\u2CEAF]+/
    end

    def name
      I18n.t("dictionary.languages.chinese")
    end
  end
end
