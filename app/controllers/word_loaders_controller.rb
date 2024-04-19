class WordLoadersController < ApplicationController
  include Loadable

  before_action :authenticate_user!

  def new
  end

  def create
    words = params[:words]
    dictionary_id = params[:dictionary_id]
    load(words, dictionary_id)
    respond_to do |format|
      format.html { redirect_to dictionary_path(dictionary_id) }
    end
  end
end
