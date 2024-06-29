# frozen_string_literal: true

require "test_helper"

class TheFreeDictionarySpanishAudioTest < ActiveSupport::TestCase
  test "should get spanish pronunciation of word" do
    statement = "palabra"
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
    assert_not result[:transcription]
  end

  test "should get empty pronunciation of statement" do
    statement = "lleno de"
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

  test "should get pronunciation no-ascii symbols" do
    statement = "orquídea"
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

  test "should get pronunciation whith help of regex" do
    statement = "orquídea"
    http_module = Class.new do
      def self.get_response(url)
        Class.new do
          def self.body
            '<div class="main-holder">
            <div id="content" class="wr">
              <div class="content-holder">
                <div class="wr" id="wr1"></div>
                <h1>orquídea</h1><span class="snd2" data-snd="es/LA/dk/dkslsgsgstnjdod5dtgk"></span> <br>También se encuentra en: <a href="//www.sinonimosgratis.com/palabra">Sinónimos</a>.<div id="relToLnks">Búsquedas relacionadas con palabra: <a href="//es.thefreedictionary.com/palabra+de+honor">palabra de honor</a></div>
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
      config.region = /(EU|LA)/
    end
    assert_equal "https://img2.tfd.com/pron/mp3/es/LA/dk/dkslsgsgstnjdod5dtgk.mp3", result[:source]
  end
end
