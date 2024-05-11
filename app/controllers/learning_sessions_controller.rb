class LearningSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dictionary, only: %i[new create destroy]

  def new
    learning_data = @dictionary.generate_learning_session_info
    @params_of_empty_data = learning_data[:params_of_empty_data]
    @word = learning_data[:word]
  end

  def create
    word = Word.find(params[:word_id])
    answer = params[:answer]
    if word.check_answer(answer)
      flash[:green] = t('learning_session.correct')
    else
      flash[:red] = "#{t('learning_session.incorrect')}. #{t('learning_session.correct')}: #{word.content}"
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
