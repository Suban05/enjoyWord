# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @last_words = Word.last_added(current_user)
    @popular_dictionaries = Dictionary.popular(current_user)
  end
end
