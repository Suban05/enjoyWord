class WordLoadersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[new create]

  def new
  end

  def create
    words = params[:words]
    dictionary_id = params[:dictionary_id]
    @words = Dictionary.write_words(@dictionary, words)
    if @words.count.positive?
      flash.now[:green] = "#{@words.count} words successfully loaded"
    else
      flash.now[:red] = "#{@words.count} words loaded. Please, check your words."
    end
  end

  private

  def set_dictionary
    @dictionary = current_user.dictionaries.find_by(id: params[:dictionary_id])
  end
end
