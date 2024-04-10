class Dictionary < ApplicationRecord
  belongs_to :user
  has_many :words
  validates :name, :translation_type, presence: true
  enum translation_type: { english_russian: 0, spanish_russian: 1 }
end
