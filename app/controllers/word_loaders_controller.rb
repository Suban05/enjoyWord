# frozen_string_literal: true

class WordLoadersController < ApplicationController
  include WordsHelper
  include WordSearchable

  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[new create]
  before_action :set_search_params, only: %i[create]

  def new
  end

  def create
    words = params[:words]
    @words = @dictionary.write_words(words)
    if @words.count.positive?
      flash.now[:green] = t("word_loader.create.success", count: @words.count)
    else
      flash.now[:red] = t("word_loader.create.unsuccess", count: @words.count)
    end
  end

  private

  def set_dictionary
    @dictionary = current_user.dictionaries.find_by(id: params[:dictionary_id])
  end
end
