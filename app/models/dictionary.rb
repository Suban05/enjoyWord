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
end
