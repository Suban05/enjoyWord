# frozen_string_literal: true

module Dictionary::Loadable
  extend ActiveSupport::Concern

  # @param words [String]
  def write_words(words)
    WordsLoading::Loading.new(
      dictionary: self,
      words: WordsLoading::Parsing.new(dictionary: self, words: words).call
    ).call
  end
end
