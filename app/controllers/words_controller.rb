# frozen_string_literal: true

class WordsController < ApplicationController
  include Pagy::Backend
  include WordsHelper
  include WordSearchable
  include TurboReturnable

  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[index new create]
  before_action :set_word, only: %i[edit update show destroy]
  before_action :set_search_params, only: %i[index create]
  before_action :set_page, only: %i[index new edit]

  def index
    @pagy, @words = pagy_countless(prepare_returnable_query(@q.result(distinct: true)), items: 10)
  end

  def new
    @word = @dictionary.words.build
  end

  def create
    @word = Word.build(words_params)
    if @word.save
      flash.now[:green] = t("word.create.success")
    else
      render :new
    end
  end

  def edit
    @dictionary = @word.dictionary
  end

  def update
    if @word.update(words_params)
      flash.now[:green] = t("word.update.success")
    else
      render :edit
    end
  end

  def show
    @pronunciation_data = @word.pronunciation
  end

  def destroy
    @word.destroy
    flash.now[:green] = t("word.destroy.success")
  end

  private

  def set_dictionary
    id = params[:dictionary_id] || params.dig(:word, :dictionary_id)
    @dictionary = current_user.dictionaries.find(id)
  end

  def set_word
    @word = Word.find(params[:id])
  end

  def words_params
    params.require(:word).permit(:content, :translation, :dictionary_id)
  end

  def set_page
    @page = params[:page]
  end
end
