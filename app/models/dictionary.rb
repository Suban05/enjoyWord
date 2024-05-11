require_relative 'languages'

class Dictionary < ApplicationRecord
  include Lingual
  include Orderable

  belongs_to :user
  has_many :words, dependent: :destroy

  scope :popular, ->(user) do
    left_joins(:words)
    .select(
      'COALESCE(count(words.id), 0) as words_count,
      max(words.created_at) as updated_at,
      dictionaries.id,
      dictionaries.name,
      dictionaries.translation_type'
    )
    .where(user_id: user.id)
    .group(:id, :name, :translation_type)
    .order('words_count DESC')
    .limit(5)
  end

  def translation_type_display
    translation_type.to_s.humanize
  end

  def reset_learned_words
    words.each do |word|
      word.learned = false
      word.save
    end
  end

  def generate_learning_session_info
    button_title = nil
    button_path = nil
    button_data = {}
    if self.words.count == 0
      content = t('learning_session.no_words')
    elsif self.words.not_learned_words.count == 0
      content = t('learning_session.words_are_learned')
      button_title = t('learning_session.learn_again')
      button_path = learn_words_again_path(dictionary_id: self)
      button_data = { turbo_method: :delete }
    end
    params_of_empty_data = {
      content: content, button_title: button_title, button_path: button_path, button_data: button_data
    }
    word = self.words.not_learned_words.first
    { word:, params_of_empty_data: }
  end
end
