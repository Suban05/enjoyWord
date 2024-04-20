require "test_helper"

class WordLoadersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @english_spanish = dictionaries(:english_spanish)
    @english_russian = dictionaries(:english_russian)
  end

  test "should get new" do
    log_in_as(@user)
    get new_word_loader_path(params: { dictionary_id:  @english_spanish} )
    assert_response :success
  end

  test "should post create english-spanish words" do
    log_in_as(@user)

    words = <<~EOM
    Hello - hola
    good - Bien
    word - palabra
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_equal 'hola', @english_spanish.words.find_by(content: 'Hello').translation
    assert_equal 'Bien', @english_spanish.words.find_by(content: 'good').translation
    assert_equal 'palabra', @english_spanish.words.find_by(content: 'word').translation
  end

  test "should post create english-russian words" do
    log_in_as(@user)

    words = <<~EOM
    Hello - привет
    good - хорошо
    word - Слово
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal 'привет', @english_russian.words.find_by(content: 'Hello').translation
    assert_equal 'хорошо', @english_russian.words.find_by(content: 'good').translation
    assert_equal 'Слово', @english_russian.words.find_by(content: 'word').translation
  end

  test "should post create english-russian words with symbols" do
    log_in_as(@user)

    words = <<~EOM
    Hello, world! - привет, мир!
    good - хорошо.
    word - Слово
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal 'привет, мир!', @english_russian.words.find_by(content: 'Hello, world!').translation
    assert_equal 'хорошо.', @english_russian.words.find_by(content: 'good').translation
    assert_equal 'Слово', @english_russian.words.find_by(content: 'word').translation
  end

  test "should post create english-spanish words with symbols" do
    log_in_as(@user)

    words = <<~EOM
    Hello, world! - ¡hola, mundo!
    good - Bien.
    word - palabra
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_equal '¡hola, mundo!', @english_spanish.words.find_by(content: 'Hello, world!').translation
    assert_equal 'Bien.', @english_spanish.words.find_by(content: 'good').translation
    assert_equal 'palabra', @english_spanish.words.find_by(content: 'word').translation
  end

  test "should post create english-russian words with dash" do
    log_in_as(@user)

    words = <<~EOM
    bored - скучающий. I am bored - мне скучно
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal "скучающий. I am bored - мне скучно", @english_russian.words.find_by(content: 'bored').translation
  end

  test "shouldn't write russian word to the english-spanish dictionary" do
    log_in_as(@user)

    words = <<~EOM
    bored - скучающий
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_not @english_spanish.words.find_by(content: 'bored')
  end

  test "shouldn't write any words if errors were" do
    skip "It skipped because it didn't implement"

    log_in_as(@user)

    words = <<~EOM
    bored - скучающий
    language - idioma
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_not @english_spanish.words.find_by(content: 'bored')
    assert_not @english_spanish.words.find_by(content: 'language')
  end
end
