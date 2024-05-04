module TheFreeDictionary
  class EnglishAudio
    def pronunciation(statement)
      TheFreeDictionary::Pronunciation.get do |config|
        config.statement = statement
        config.language = "en"
        config.region = "US"
      end
    end
  end
end
