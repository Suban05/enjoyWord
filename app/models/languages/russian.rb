module Languages
  class Russian < Language
    def word_template
      /[а-яА-Я]+/
    end
  end
end
