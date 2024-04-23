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
    @words = Dictionary.write_words(@dictionary, words)
    if @words.count.positive?
      flash.now[:green] = "#{@words.count} words successfully loaded"
    else
      flash.now[:red] = "#{@words.count} words loaded. Please, check your words"
    end
  end

  private

  def set_dictionary
    @dictionary = current_user.dictionaries.find_by(id: params[:dictionary_id])
  end
end
