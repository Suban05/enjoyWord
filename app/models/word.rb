class Word < ApplicationRecord
  belongs_to :dictionary
  validates :content, :translation, presence: true
end
