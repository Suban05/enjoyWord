require_relative 'languages'

class Dictionary < ApplicationRecord
  belongs_to :user
  has_many :words
  validates :name, :translation_type, presence: true

  # @param words [String]
  def self.write_words(dictionary, words)
    languages = dictionary.translation_type.to_s.split('_')
    first_language = language_mappings[languages.first.to_sym]
    second_language = language_mappings[languages.second.to_sym]
    word_pairs = words.scan(/(#{first_language.word_template})\s*-\s*(#{second_language.word_template})/)
    word_pairs.each do |pair|
      word = dictionary.words.build(content: pair.first, translation: pair.second)
      word.save
    end
  end

  def self.translation_types
    languages = language_mappings.keys
    types = []
    languages.each do |first|
      languages.each do |second|
        next if first == second

        types << "#{first}_#{second}".to_sym
      end
    end
    types
  end

  def self.language_mappings
    {
      english: English,
      russian: Russian,
      spanish: Spanish,
    }
  end

  enum translation_type: translation_types

end
