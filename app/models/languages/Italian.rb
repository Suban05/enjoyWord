module Languages
  class Italian < Language
    def word_template
      /[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]+/
    end
  end
end
