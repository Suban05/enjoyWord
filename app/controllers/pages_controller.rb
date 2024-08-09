# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!
  include DictionariesHelper

  def home
    @last_words = Word.last_added(current_user)
    @popular_dictionaries = Dictionary.popular(current_user)
    @word_of_day = current_user.favourite_language_as_object.word_of_day
  end
end
