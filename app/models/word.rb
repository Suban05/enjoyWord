class Word < ApplicationRecord
  belongs_to :dictionary
  has_many :examples, dependent: :destroy
  validates :content, :translation, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[content translation]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[dictionary]
  end
end
