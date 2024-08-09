# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!
  include DictionariesHelper

  def home
    @last_words = Word.last_added(current_user)
    @popular_dictionaries = Dictionary.popular(current_user)
    @pronunciation_data = current_user.favourite_language_as_object.word_of_day
    @word_of_day = Word.new(content: @pronunciation_data[:word], translation: @pronunciation_data[:definition])
  end
end
