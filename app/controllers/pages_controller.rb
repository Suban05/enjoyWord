class PagesController < ApplicationController
  def home
    @last_words = Word.last_added(current_user)
  end
end
