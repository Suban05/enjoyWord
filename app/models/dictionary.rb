require_relative 'languages'

class Dictionary < ApplicationRecord
  include DictionaryWritable

  belongs_to :user
  has_many :words
end
