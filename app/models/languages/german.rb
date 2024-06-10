module Languages
  class German < Language
    def word_template
      /[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]+/
    end
  end
end
