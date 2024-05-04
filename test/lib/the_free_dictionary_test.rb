require 'test_helper'

class TheFreeDictionaryTest < ActiveSupport::TestCase
  test 'should get empty pronunciation' do
    statement = '0120324'
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            ''
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
    assert_equal '', result[:source]
  end

  test 'should get english pronunciation of word' do
    statement = 'glossary'
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            '<div class="main-holder">
            <div id="content" class="zi">
              <div class="content-holder">
                <div class="zi" id="zi1"></div>
                <h1>glossary</h1><span class="snd2" data-snd="en/US/st/stdyd3sjsssydsstykgk"></span><span class=snd2 data-snd="en/UK/st/stdyd3sjsssydsstykgk"></span><br>Also found in: <a href="//www.freethesaurus.com/glossary">Thesaurus</a>, <a href="//medical-dictionary.thefreedictionary.com/glossary">Medical</a>, <a href="//legal-dictionary.thefreedictionary.com/glossary">Legal</a>, <a href="//acronyms.thefreedictionary.com/glossary">Acronyms</a>, <a href="//encyclopedia2.thefreedictionary.com/glossary">Encyclopedia</a>, <a href="//encyclopedia.thefreedictionary.com/glossary">Wikipedia</a>.<div id="relToLnks">Related to glossary: <a href="//www.thefreedictionary.com/dictionary">dictionary</a></div>'
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
  end

  test 'should get spanish pronunciation of word' do
    statement = 'palabra'
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            '<div class="main-holder">
            <div id="content" class="wr">
              <div class="content-holder">
                <div class="wr" id="wr1"></div>
                <h1>palabra</h1><span class="snd2" data-snd="es/EU/dk/dkskdhdndfdssydyhn"></span> <br>También se encuentra en: <a href="//www.sinonimosgratis.com/palabra">Sinónimos</a>.<div id="relToLnks">Búsquedas relacionadas con palabra: <a href="//es.thefreedictionary.com/palabra+de+honor">palabra de honor</a></div>
              <div id="MainTxt">'
          end
        end
      end
    end
    result = TheFreeDictionary::Pronunciation.get do |config|
      config.statement = statement
      config.http_module = http_module
      config.hostname = "es.thefreedictionary.com"
      config.language = "es"
      config.region = "EU"
    end
    assert_equal "https://img2.tfd.com/pron/mp3/es/EU/dk/dkskdhdndfdssydyhn.mp3", result[:source]
  end

  test 'should get empty pronunciation of statement' do
    statement = 'lleno de'
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            '<div class="main-holder">
            <div id="content" class="wr">
              <div class="content-holder">
                <div class="wr" id="wr1"></div>
                <h1>lleno de</h1><div id="MainTxt">
                <div id="MainTxt">'
          end
        end
      end
    end
    result = TheFreeDictionary::Pronunciation.get do |config|
      config.statement = statement
      config.http_module = http_module
      config.hostname = "es.thefreedictionary.com"
      config.language = "es"
      config.region = "EU"
    end
    assert_equal "", result[:source]
  end

  test 'should get pronunciation no-ascii symbols' do
    statement = 'orquídea'
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            '<div class="main-holder">
            <div id="content" class="wr">
              <div class="content-holder">
                <div class="wr" id="wr1"></div>
                <h1>orquídea</h1><span class="snd2" data-snd="es/EU/dk/dkslsgsgstnjdod5dtgk"></span> <br>También se encuentra en: <a href="//www.sinonimosgratis.com/palabra">Sinónimos</a>.<div id="relToLnks">Búsquedas relacionadas con palabra: <a href="//es.thefreedictionary.com/palabra+de+honor">palabra de honor</a></div>
                '
          end
        end
      end
    end
    result = TheFreeDictionary::Pronunciation.get do |config|
      config.statement = statement
      config.http_module = http_module
      config.hostname = "es.thefreedictionary.com"
      config.language = "es"
      config.region = "EU"
    end
    assert_equal "https://img2.tfd.com/pron/mp3/es/EU/dk/dkslsgsgstnjdod5dtgk.mp3", result[:source]
  end
end
