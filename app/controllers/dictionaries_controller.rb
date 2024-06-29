# frozen_string_literal: true

class DictionariesController < ApplicationController
  include Pagy::Backend
  include TurboReturnable

  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[edit update show destroy]

  def index
    @pagy, @dictionaries = pagy_countless(prepare_returnable_query(current_user.dictionaries), items: 15)
  end

  def new
    @dictionary = current_user.dictionaries.build
  end

  def create
    @dictionary = current_user.dictionaries.build(dictionaries_params)
    if @dictionary.save
      flash.now[:green] = t("dictionary.create.success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @dictionary.update(dictionaries_params)
      flash.now[:green] = t("dictionary.update.success")
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @dictionary.destroy
    flash.now[:green] = t("dictionary.destroy.success")
  end

  private

  def set_dictionary
    @dictionary = current_user.dictionaries.find(params[:id])
  end

  def dictionaries_params
    params.require(:dictionary).permit(:name, :translation_type)
  end

  def set_page
    @page = params[:page]
  end
end
