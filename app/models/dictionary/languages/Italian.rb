# frozen_string_literal: true

module Dictionary::Languages
  class Italian < Language
    def word_template
      /[a-zA-ZàèéìíîòóùúÀÈÉÌÍÎÒÓÙÚ]+/
    end
  end
end
