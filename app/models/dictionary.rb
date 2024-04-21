require_relative 'languages'

class Dictionary < ApplicationRecord
  include DictionaryWritable

  belongs_to :user
  has_many :words

  def translation_type_display
    translation_type.to_s.humanize
  end
end
