class Dictionary < ApplicationRecord
  belongs_to :user
  has_many :words
  validates :name, :translation_type, presence: true
  enum translation_type: %i[english_russian spanish_russian english_spanish spanish_english]
end
