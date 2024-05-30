class Word < ApplicationRecord
  include Orderable

  belongs_to :dictionary
  has_many :examples, dependent: :destroy
  validates :content, :translation, presence: true

  scope :last_added, ->(user) { latest_ordered.where(dictionary_id: user.dictionaries.all).first(5) }
  scope :not_learned_words, -> { latest_ordered.where(learned: false) }

  def check_answer(answer)
    if self.content.strip.downcase == answer.strip.downcase
      self.learned = true
      return self.save
    end
    false
  end

  def pronunciation
    language_class = self.dictionary.available_languages[:first_language]
    language = language_class.new(self.dictionary.available_languages_audio[:first_language].new)
    language.pronunciation(self)[:source]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[content translation]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[dictionary]
  end
end
