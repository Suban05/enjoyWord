require_relative 'languages'

class Dictionary < ApplicationRecord
  include DictionaryWritable
  include Orderable

  belongs_to :user
  has_many :words, dependent: :destroy

  def translation_type_display
    translation_type.to_s.humanize
  end
end
