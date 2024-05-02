class LearningSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[new create destroy]

  def new
    button_title = nil
    button_path = nil
    button_data = {}
    if @dictionary.words.count == 0
      content = "There aren't any words for learning"
    elsif @dictionary.words.not_learned_words.count == 0
      content = "The all words are learned"
      button_title = 'Learn again'
      button_path = learn_words_again_path(dictionary_id: @dictionary)
      button_data = { turbo_method: :delete }
    end
    @params_of_empty_data = {
      content: content, button_title: button_title, button_path: button_path, button_data: button_data
    }
    @word = @dictionary.words.not_learned_words.first
  end

  def create
    word = Word.find(params[:word_id])
    answer = params[:answer]
    if word.check_answer(answer)
      flash[:green] = 'Correct'
    else
      flash[:red] = "Incorrect. Correct: #{word.content}"
    end
    redirect_to new_learning_session_path(dictionary_id: word.dictionary)
  end

  def destroy
    @dictionary.reset_learned_words
    redirect_to new_learning_session_path(dictionary_id: @dictionary)
  end

  private

  def set_dictionary
    @dictionary = current_user.dictionaries.find(params[:dictionary_id])
  end
end
