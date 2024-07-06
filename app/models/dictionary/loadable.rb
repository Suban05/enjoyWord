module Dictionary::Loadable
  extend ActiveSupport::Concern

  # @param words [String]
  def write_words(words)
    word_pairs = WordsLoading::Parsing.new(dictionary: self, words: words).call
    WordsLoading::Loading.new(dictionary: self, words: word_pairs).call
  end
end
