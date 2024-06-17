module TheFreeDictionary
  class FrenchAudio
    def pronunciation(statement)
      TheFreeDictionary::Pronunciation.get do |config|
        config.statement = statement
        config.language = "it"
        config.region = "IT"
      end
    end
  end
end
