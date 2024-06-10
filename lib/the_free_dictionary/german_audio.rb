module TheFreeDictionary
  class GermanAudio
    def pronunciation(statement)
      TheFreeDictionary::Pronunciation.get do |config|
        config.statement = statement
        config.language = "de"
        config.region = "DE"
      end
    end
  end
end
