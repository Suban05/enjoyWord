# frozen_string_literal: true

module Dictionary::Languages
  class Spanish < Language
    def word_template
      /[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]+/
    end
  end
end
