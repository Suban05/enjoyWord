class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[index new]
  before_action :set_word, only: %i[edit update show destroy]

  def index
    @words = @dictionary.words.all
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
    @dictionary = current_user.dictionaries.find_by(id: params[:dictionary_id])
  end

  def set_word
    @word = Word.find_by(id: params[:id])
  end

  def words_params
    params.require(:word).permit(:content, :translation, :dictionary_id)
  end
end
