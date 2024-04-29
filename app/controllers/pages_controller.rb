class PagesController < ApplicationController
  def home
    @last_words = Word.last_added(current_user)
    @popular_dictionaries = Dictionary.popular(current_user)
  end
end
