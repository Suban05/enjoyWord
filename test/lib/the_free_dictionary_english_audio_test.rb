# frozen_string_literal: true

require "test_helper"

class TheFreeDictionaryEnglishAudioTest < ActiveSupport::TestCase
  test "should get empty pronunciation" do
    statement = "0120324"
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            ""
          end
        end
      end
    end
    result = TheFreeDictionary::Pronunciation.get do |config|
      config.statement = statement
      config.http_module = http_module
      config.hostname = "www.thefreedictionary.com"
      config.language = "en"
      config.region = "US"
    end
    assert_equal "", result[:source]
  end

  test "should get english pronunciation of word" do
    statement = "glossary"
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            '<div class="main-holder">
            <div id="content" class="zi">
              <div class="content-holder">
                <div class="zi" id="zi1"></div>
                <h1>glossary</h1><span class="snd2" data-snd="en/US/st/stdyd3sjsssydsstykgk"></span><span class=snd2 data-snd="en/UK/st/stdyd3sjsssydsstykgk"></span><br>Also found in: <a href="//www.freethesaurus.com/glossary">Thesaurus</a>, <a href="//medical-dictionary.thefreedictionary.com/glossary">Medical</a>, <a href="//legal-dictionary.thefreedictionary.com/glossary">Legal</a>, <a href="//acronyms.thefreedictionary.com/glossary">Acronyms</a>, <a href="//encyclopedia2.thefreedictionary.com/glossary">Encyclopedia</a>, <a href="//encyclopedia.thefreedictionary.com/glossary">Wikipedia</a>.<div id="relToLnks">Related to glossary: <a href="//www.thefreedictionary.com/dictionary">dictionary</a></div>
                <span onclick="pron_key(1)" class="pron">ˈɡlɒsərɪ</span>'
          end
        end
      end
    end
    result = TheFreeDictionary::Pronunciation.get do |config|
      config.statement = statement
      config.http_module = http_module
      config.hostname = "www.thefreedictionary.com"
      config.language = "en"
      config.region = "US"
    end
    assert_equal "https://img2.tfd.com/pron/mp3/en/US/st/stdyd3sjsssydsstykgk.mp3", result[:source]
    assert_equal "ˈɡlɒsərɪ", result[:transcription]
  end

  test "should get english transcription of word if html has parenthesis" do
    statement = "affordable"
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            '<div class="main-holder">
            <div id="content" class="zi">
              <div class="content-holder">
                <div class="zi" id="zi1"></div>
                <h1>affordable</h1><span class="snd2" data-snd="en/US/st/stdyd3sjsssydsstykgk"></span><span class=snd2 data-snd="en/UK/st/stdyd3sjsssydsstykgk"></span><br>Also found in: <a href="//www.freethesaurus.com/affordable">Thesaurus</a>, <a href="//medical-dictionary.thefreedictionary.com/affordable">Medical</a>, <a href="//legal-dictionary.thefreedictionary.com/affordable">Legal</a>, <a href="//acronyms.thefreedictionary.com/affordable">Acronyms</a>, <a href="//encyclopedia2.thefreedictionary.com/affordable">Encyclopedia</a>, <a href="//encyclopedia.thefreedictionary.com/affordable">Wikipedia</a>.<div id="relToLnks">Related to glossary: <a href="//www.thefreedictionary.com/dictionary">dictionary</a></div>
                <span onclick="pron_key(1)" class="pron"> (əˈfɔr də bəl, əˈfoʊr-) </span>'
          end
        end
      end
    end
    result = TheFreeDictionary::Pronunciation.get do |config|
      config.statement = statement
      config.http_module = http_module
      config.hostname = "www.thefreedictionary.com"
      config.language = "en"
      config.region = "US"
    end
    assert_equal "əˈfɔr də bəl, əˈfoʊr-", result[:transcription]
  end
end
