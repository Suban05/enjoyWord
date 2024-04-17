require "test_helper"

class WordLoadersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @dictionary = dictionaries(:one)
  end

  test "should get new" do
    log_in_as(@user)
    get new_word_loader_path
    assert_response :success
  end

  test "should get create" do
    log_in_as(@user)

    words = <<~EOM
    Hello - hola
    good - Bien
    word - palabra
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @dictionary.id }

    assert_redirected_to @dictionary

    assert_equal 'hola', @dictionary.words.find_by(content: 'Hello').translation
    assert_equal 'Bien', @dictionary.words.find_by(content: 'good').translation
    assert_equal 'palabra', @dictionary.words.find_by(content: 'word').translation
  end
end
