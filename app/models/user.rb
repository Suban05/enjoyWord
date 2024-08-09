# frozen_string_literal: true

class User < ApplicationRecord
  has_many :dictionaries, dependent: :destroy

  has_secure_password

  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  def favourite_language_as_object
    return Dictionary::Language.new if self.favourite_language.nil? || self.favourite_language.empty?

    lang_id = self.favourite_language.to_sym
    external = Dictionary.external[lang_id].new
    lang = Dictionary::Language.find_by_id(lang_id)
    lang.new(external)
  end
end
