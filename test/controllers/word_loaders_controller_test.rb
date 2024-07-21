# frozen_string_literal: true

require "test_helper"

class WordLoadersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @english_spanish = dictionaries(:english_spanish)
    @english_russian = dictionaries(:english_russian)
    @german_russian = dictionaries(:german_russian)
    @french_russian = dictionaries(:french_russian)
    @italian_russian = dictionaries(:italian_russian)
    @chinese_russian = dictionaries(:chinese_russian)
    @russian_english = dictionaries(:russian_english)
  end

  test "should get new" do
    log_in_as(@user)
    get new_word_loader_path(params: { dictionary_id:  @english_spanish })
    assert_response :success
  end

  test "should create english-spanish words" do
    log_in_as(@user)

    words = <<~EOM
    Hello - hola
    good - Bien
    word - palabra
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_equal "hola", @english_spanish.words.find_by(content: "Hello").translation
    assert_equal "Bien", @english_spanish.words.find_by(content: "good").translation
    assert_equal "palabra", @english_spanish.words.find_by(content: "word").translation
  end

  test "should create english-russian words" do
    log_in_as(@user)

    words = <<~EOM
    Hello - привет
    good - хорошо
    word - Слово
    Attitude [ˈætɪˌtjuːd] — отношение
    on - на
    a - артикль
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal "привет", @english_russian.words.find_by(content: "Hello").translation
    assert_equal "хорошо", @english_russian.words.find_by(content: "good").translation
    assert_equal "Слово", @english_russian.words.find_by(content: "word").translation
    assert_equal "на", @english_russian.words.find_by(content: "on").translation
    assert_equal "артикль", @english_russian.words.find_by(content: "a").translation
    assert_equal "отношение", @english_russian.words.find_by(content: "Attitude").translation
  end

  test "should create english-russian words with symbols" do
    log_in_as(@user)

    words = <<~EOM
    Hello, world! - привет, мир!
    good - хорошо.
    word - Слово
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal "привет, мир!", @english_russian.words.find_by(content: "Hello, world!").translation
    assert_equal "хорошо.", @english_russian.words.find_by(content: "good").translation
    assert_equal "Слово", @english_russian.words.find_by(content: "word").translation
  end

  test "should create english-spanish words with symbols" do
    log_in_as(@user)

    words = <<~EOM
    Hello, world! - ¡hola, mundo!
    good - Bien.
    word - palabra
    and - y
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_equal "¡hola, mundo!", @english_spanish.words.find_by(content: "Hello, world!").translation
    assert_equal "Bien.", @english_spanish.words.find_by(content: "good").translation
    assert_equal "palabra", @english_spanish.words.find_by(content: "word").translation
    assert_equal "y", @english_spanish.words.find_by(content: "and").translation
  end

  test "should create english-russian words with dash" do
    log_in_as(@user)

    words = <<~EOM
    bored - скучающий. I am bored - мне скучно
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal "скучающий. I am bored - мне скучно", @english_russian.words.find_by(content: "bored").translation
  end

  test "shouldn't write russian word to the english-spanish dictionary" do
    log_in_as(@user)

    words = <<~EOM
    bored - скучающий
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_not @english_spanish.words.find_by(content: "bored")
  end

  test "should write german words to the german-russian dictionary" do
    log_in_as(@user)

    words = <<~EOM
    verheiratet - женатый, замужняя
    verwitwet - овдовевший
    die Arbeit - труд, работа
    übrigens - впрочем, вообще
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @german_russian.id }

    assert @german_russian.words.find_by(content: "verheiratet")
    assert @german_russian.words.find_by(content: "verwitwet")
    assert @german_russian.words.find_by(content: "die Arbeit")
    assert @german_russian.words.find_by(content: "übrigens")
  end

  test "should write french words to the french-russian dictionary" do
    log_in_as(@user)

    words = <<~EOM
    Bonjour - здравствуйте
    Au revoir - до свидания
    S'il vous plaît - пожалуйста
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @french_russian.id }

    assert @french_russian.words.find_by(content: "Bonjour")
    assert @french_russian.words.find_by(content: "Au revoir")
    assert @french_russian.words.find_by(content: "S'il vous plaît")
  end

  test "should write italian words to the italian-russian dictionary" do
    log_in_as(@user)

    words = <<~EOM
    Buongiorno - здравствуйте
    Ciao - до свидания
    Entrata - вход
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @italian_russian.id }

    assert @italian_russian.words.find_by(content: "Buongiorno")
    assert @italian_russian.words.find_by(content: "Ciao")
    assert @italian_russian.words.find_by(content: "Entrata")
  end

  test "should create chinese-russian words with symbols" do
    log_in_as(@user)

    words = <<~EOM
    你好 - привет
    谢谢 - спасибо
    是 - Да
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @chinese_russian.id }

    assert_equal "привет", @chinese_russian.words.find_by(content: "你好").translation
    assert_equal "спасибо", @chinese_russian.words.find_by(content: "谢谢").translation
    assert_equal "Да", @chinese_russian.words.find_by(content: "是").translation
  end

  test "loads pair with transcription" do
    log_in_as(@user)

    words = <<~EOM
    Attitude [ˈætɪˌtjuːd] - отношение
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal "отношение", @english_russian.words.find_by(content: "Attitude").translation
  end

  test "loads pair with underscore" do
    log_in_as(@user)

    words = <<~EOM
    Attitude — отношение
    despicable — гадкий, гнусный, презренный
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal "отношение", @english_russian.words.find_by(content: "Attitude").translation
    assert_equal "гадкий, гнусный, презренный", @english_russian.words.find_by(content: "despicable").translation
  end

  test "loads pair with underscore and transcription" do
    log_in_as(@user)

    words = <<~EOM
    Attitude [ˈætɪˌtjuːd] — отношение
    despicable [dɪˈspɪkəbəl] — гадкий, гнусный, презренный
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_russian.id }

    assert_equal "отношение", @english_russian.words.find_by(content: "Attitude").translation
    assert_equal "гадкий, гнусный, презренный", @english_russian.words.find_by(content: "despicable").translation
  end

  test "should create russian-english words" do
    log_in_as(@user)

    words = <<~EOM
    привет - Hello
    хорошо - good
    Слово - word
    в - in
    для - for
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @russian_english.id }

    assert_equal "Hello", @russian_english.words.find_by(content: "привет").translation
    assert_equal "good", @russian_english.words.find_by(content: "хорошо").translation
    assert_equal "word", @russian_english.words.find_by(content: "Слово").translation
    assert_equal "in", @russian_english.words.find_by(content: "в").translation
    assert_equal "for", @russian_english.words.find_by(content: "для").translation
  end

  test "shouldn't write any words if errors were" do
    skip "It skipped because it didn't implement"

    log_in_as(@user)

    words = <<~EOM
    bored - скучающий
    language - idioma
    EOM

    post word_loaders_path params: { words: words, dictionary_id: @english_spanish.id }

    assert_not @english_spanish.words.find_by(content: "bored")
    assert_not @english_spanish.words.find_by(content: "language")
  end
end
