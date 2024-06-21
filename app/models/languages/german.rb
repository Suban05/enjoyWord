module Languages
  class German < Language
    def word_template
      /[a-zA-ZäöüßÄÖÜ]+/
    end
  end
end
