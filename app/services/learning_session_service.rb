class LearningSessionService
  def initialize(**args)
    @controller = args[:controller]
    @dictionary = args[:dictionary]
  end

  def call
    button_title = nil
    button_path = nil
    button_data = {}
    if @dictionary.words.count == 0
      content = I18n.t('learning_session.no_words')
    elsif @dictionary.words.not_learned_words.count == 0
      content = I18n.t('learning_session.words_are_learned')
      button_title = I18n.t('learning_session.learn_again')
      button_path = @controller.learn_words_again_path(dictionary_id: @dictionary)
      button_data = { turbo_method: :delete }
    end
    params_of_empty_data = {
      content:, button_title:, button_path:, button_data:
    }
    word = @dictionary.words.not_learned_words.first
    { word:, params_of_empty_data: }
  end
end
