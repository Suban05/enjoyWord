class WordsController < ApplicationController
  include WordsHelper
  include WordSearchable

  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[index new create]
  before_action :set_word, only: %i[edit update show destroy]
  before_action :set_search_params, only: %i[index create]

  def index
    @words = @q.result(distinct: true).order(:created_at)
  end

  def new
    @word = @dictionary.words.build
  end

  def create
    @word = Word.build(words_params)
    if @word.save
      flash.now[:green] = t('word.create.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update(words_params)
      flash.now[:green] = t('word.update.success')
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @word.destroy
    flash.now[:green] = t('word.destroy.success')
  end

  private

  def set_dictionary
    id = params[:dictionary_id] || params[:word][:dictionary_id]
    @dictionary = current_user.dictionaries.find_by(id:)
  end

  def set_word
    @word = Word.find_by(id: params[:id])
  end

  def words_params
    params.require(:word).permit(:content, :translation, :dictionary_id)
  end
end
