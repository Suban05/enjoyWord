class Word < ApplicationRecord
  belongs_to :dictionary
  has_many :examples
  validates :content, :translation, presence: true
end
