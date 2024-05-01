class LearningSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[new create]

  def new
    if @dictionary.words.count == 0
      flash[:green] = "There aren't any words for learning"
    elsif @dictionary.words.latest_ordered.where(learned: false).count == 0
      flash[:green] = "All words learned"
    end
    @word = @dictionary.words.latest_ordered.where(learned: false).first
  end

  def create
    word = Word.find(params[:word_id])
    answer = params[:answer]
    if word.content == answer
      word.learned = true
      word.save
      flash[:green] = 'Correct'
    else
      flash[:red] = "Incorrect. Correct: #{word.content}"
    end
    redirect_to new_learning_session_path(dictionary_id: word.dictionary)
  end

  private

  def set_dictionary
    @dictionary = current_user.dictionaries.find(params[:dictionary_id])
  end
end
