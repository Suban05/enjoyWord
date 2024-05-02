require "test_helper"

class LearningSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @dictionary = dictionaries(:english_russian)
  end

  test "should get new" do
    log_in_as(@user)
    get new_learning_session_path(dictionary_id: @dictionary)
    assert_response :success
  end

  test "should learn a word" do
    log_in_as(@user)

    hello = words(:hello)
    assert_difference ->{ @dictionary.words.not_learned_words.count }, -1 do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: hello, answer: 'hello' }
    end
    assert_redirected_to new_learning_session_path(dictionary_id: @dictionary)
    assert_not flash.empty?
  end

  test "should learn words" do
    log_in_as(@user)

    hello = words(:hello)
    assert_difference ->{ @dictionary.words.not_learned_words.count }, -1 do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: hello, answer: 'hello' }
    end
    assert_not flash.empty?

    file = words(:file)
    assert_no_difference ->{ @dictionary.words.not_learned_words.count } do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: file, answer: 'faile' }
    end
    assert_not flash.empty?

    file = words(:file)
    assert_difference ->{ @dictionary.words.not_learned_words.count }, -1 do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: file, answer: 'file' }
    end
    assert_not flash.empty?

    keyboard = words(:keyboard)
    assert_difference ->{ @dictionary.words.not_learned_words.count }, -1 do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: keyboard, answer: 'keyboard' }
    end
    assert_not flash.empty?
    assert 0, @dictionary.words.not_learned_words.count
  end

  test "should learn word without dependency of register" do
    log_in_as(@user)

    hello = words(:hello)
    assert_difference ->{ @dictionary.words.not_learned_words.count }, -1 do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: hello, answer: 'Hello' }
    end
    assert_not flash.empty?
  end

  test "should learn word without dependency of whitespase at the end" do
    log_in_as(@user)

    hello = words(:hello)
    assert_difference ->{ @dictionary.words.not_learned_words.count }, -1 do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: hello, answer: 'hello ' }
    end
    assert_not flash.empty?
  end

  test "should learn word without dependency of register and dependency of whitespase at the end" do
    log_in_as(@user)

    hello = words(:hello)
    assert_difference ->{ @dictionary.words.not_learned_words.count }, -1 do
      post learning_sessions_path params: { dictionary_id: @dictionary, word_id: hello, answer: 'Hello ' }
    end
    assert_not flash.empty?
  end

  test 'should reset learned words' do
    log_in_as(@user)
    @dictionary.words.each do |word|
      word.learned = true
      word.save
    end
    learned_count = @dictionary.words.where(learned: true).count
    assert_difference ->{ @dictionary.words.not_learned_words.count }, learned_count do
      delete learn_words_again_path params: { dictionary_id: @dictionary }
    end
  end
end
