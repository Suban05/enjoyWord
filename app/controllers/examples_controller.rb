# frozen_string_literal: true

class ExamplesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_word, only: %i[index new]
  before_action :set_example, only: %i[edit update show destroy]

  def index
    @examples = @word.examples.all
  end

  def new
    @example = @word.examples.build
  end

  def create
    @example = Example.build(examples_params)
    if @example.save
      flash.now[:green] = t("example.create.success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @example.update(examples_params)
      flash.now[:green] = t("example.update.success")
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @example.destroy
    flash.now[:green] = t("example.destroy.success")
  end

  private

  def set_word
    @word = Word.find(params[:word_id])
  end

  def set_example
    @example = Example.find(params[:id])
  end

  def examples_params
    params.require(:example).permit(:content, :translation, :word_id)
  end
end
