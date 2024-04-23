module WordsHelper
  def show_header(locals)
    turbo_stream.replace Word.new,
    partial: 'shared/header',
    locals:
  end

  def locals(list_title_path:, dictionary_id:, **options)
    {
      list_title_path:,
      create_button_title_path: t('word.index.new_word'),
      create_button_link: new_word_path(dictionary_id:),
      load_words_button_link: new_word_loader_path(dictionary_id:),
      search_form: 'words/search_form',
      new_object: Word.new
    }.merge(options)
  end
end
